//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 01/11/2021.
//


import Foundation

public struct GetOrderBookRequestParameters: RequestParameters {

    public let symbol: Symbol
    public let limit: Int

    public init(symbol: Symbol, limit: Int) {
        self.symbol = symbol
        self.limit = limit
    }
}
