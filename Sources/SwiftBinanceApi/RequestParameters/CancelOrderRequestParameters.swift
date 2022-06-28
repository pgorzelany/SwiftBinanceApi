//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 08/11/2021.
//


import Foundation

public struct CancelOrderRequestParameters: RequestParameters {

    public let symbol: Symbol
    public let orderId: Int

    public init(symbol: Symbol, orderId: Int) {
        self.symbol = symbol
        self.orderId = orderId
    }

    public init(order: OrderDetails) {
        self.symbol = order.symbol
        self.orderId = order.orderId
    }
}
