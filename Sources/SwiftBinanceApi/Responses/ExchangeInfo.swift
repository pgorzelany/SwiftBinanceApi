//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 31/10/2021.
//


import Foundation

public struct ExchangeInfo: ApiResponse {
    public let timezone: String
    public let serverTime: Int
    public let rateLimits: [RateLimit]
//    let exchangeFilters: [JSONAny]
    public let symbols: [SymbolInfo]

    public var symbolInfo: [Symbol: SymbolInfo] {
        let zipped = symbols.map({ ($0.symbol, $0) })
        return Dictionary(uniqueKeysWithValues: zipped)
    }
}
