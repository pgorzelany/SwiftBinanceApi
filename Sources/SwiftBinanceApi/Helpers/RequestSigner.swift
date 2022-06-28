//
//  File.swift
//  
//
//  Created by piotrg on 27/10/2021.
//

import CryptoKit
import Foundation

class RequestSigner {

    // MARK: Properties

    private let secretKey: String
    private let symmetricKey: SymmetricKey

    // MARK: Lifecycle

    init(secretKey: String) {
        self.secretKey = secretKey
        self.symmetricKey = SymmetricKey(data: secretKey.data(using: .utf8)!)
    }

    // MARK: Methods

    func getHmacSignature(for message: String) -> String {
        let signature = HMAC<SHA256>.authenticationCode(for: message.data(using: .utf8)!, using: symmetricKey)
        return Data(signature).map { String(format: "%02hhx", $0) }.joined()
    }
}
