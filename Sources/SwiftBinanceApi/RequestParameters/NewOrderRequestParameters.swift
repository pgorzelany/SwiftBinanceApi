//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 03/11/2021.
//


import Foundation

public struct NewOrderRequestParameters: RequestParameters {

    public let symbol: Symbol
    public let side: OrderSide
    public let type: OrderType = .limitMaker
    public let price: Decimal
    public let quantity: Decimal

    public init(symbol: Symbol, side: OrderSide, price: Decimal, quantity: Decimal) {
        self.symbol = symbol
        self.side = side
        self.price = price
        self.quantity = quantity
    }
}

extension NewOrderRequestParameters: CustomStringConvertible {
    public var description: String {
        return "\(side.rawValue) \(symbol), price: \(price), quantity: \(quantity)"
    }
}
