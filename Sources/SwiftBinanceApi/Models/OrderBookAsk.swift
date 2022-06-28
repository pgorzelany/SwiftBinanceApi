//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 01/11/2021.
//

import Foundation

public struct OrderBookAsk: Codable {
    enum CodingKeys: CodingKey {
        case price
        case quantity
    }

    public let price: Decimal
    public let quantity: Decimal

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let priceString = try container.decode(String.self)
        let quantityString = try container.decode(String.self)
        guard let price = Decimal(string: priceString), let quantity = Decimal(string: quantityString) else {
            throw DecodingError.typeMismatch(Decimal.self, DecodingError.Context(codingPath: [CodingKeys.price, CodingKeys.quantity], debugDescription: "Could not initialize price or quantity", underlyingError: nil))
        }
        self.price = price
        self.quantity = quantity
    }
}
