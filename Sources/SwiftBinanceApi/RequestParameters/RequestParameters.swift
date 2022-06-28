//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 31/10/2021.
//

import Foundation

public protocol RequestParameters: Encodable {
    func toDictionary() throws -> [String: Any]
}

extension RequestParameters {
    public func toDictionary() throws -> [String: Any] {
        let encoder = BinanceJsonEncoder()
        let jsonData = try encoder.encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
        guard let dictionary = jsonObject as? [String: Any] else {
            fatalError("Invalid Parameters")
        }
        return dictionary
    }
}
