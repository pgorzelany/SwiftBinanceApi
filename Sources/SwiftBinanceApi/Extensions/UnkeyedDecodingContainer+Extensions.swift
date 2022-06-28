//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 01/11/2021.
//

import Foundation

extension UnkeyedDecodingContainer {
    mutating func decode(_ type: Decimal.Type) throws -> Decimal {
        let stringValue = try decode(String.self)
        guard let decimalValue = Decimal(string: stringValue) else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Could not convert String to Decimal", underlyingError: nil)
            throw DecodingError.typeMismatch(type, context)
        }
        return decimalValue
    }
}
