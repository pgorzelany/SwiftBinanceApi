//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 30/10/2021.
//

import Foundation

extension KeyedDecodingContainer {
    func decode(_ type: Decimal.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Decimal {
        let stringValue = try decode(String.self, forKey: key)
        guard let decimalValue = Decimal(string: stringValue) else {
            let context = DecodingError.Context(codingPath: [key], debugDescription: "The key \(key) couldn't be converted to a Decimal value")
            throw DecodingError.typeMismatch(type, context)
        }
        return decimalValue
    }

    func decodeIfPresent(_ type: Decimal.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Decimal? {
        guard let stringValue = try decodeIfPresent(String.self, forKey: key) else {
            return nil
        }
        guard let decimalValue = Decimal(string: stringValue) else {
            let context = DecodingError.Context(codingPath: [key], debugDescription: "The key \(key) couldn't be converted to a Decimal value")
            throw DecodingError.typeMismatch(type, context)
        }
        return decimalValue
    }
}
