//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 29/10/2021.
//

import Foundation

public struct ErrorResponse: LocalizedError, Decodable {
    public let code: Int
    public let msg: String

    public var errorDescription: String? {
        return msg
    }
}
