//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 16/11/2021.
//

import Foundation

extension KeyedEncodingContainer {

    public mutating func encode(_ value: Decimal, forKey key: KeyedEncodingContainer<K>.Key) throws {
        let stringValue = "\(value)"
        try encode(stringValue, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Decimal?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        let stringValue = value?.stringValue()
        try encodeIfPresent(stringValue, forKey: key)
    }
}
