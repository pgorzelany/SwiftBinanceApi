//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 09/06/2022.
//


import Foundation

public struct GetCandleStickDataForSymbolsRequestParameters: RequestParameters {

    public let symbols: [Symbol]
    public let interval: CandleInterval
    public let limit: Int
    public let startTime: Date?
    public let endTime: Date?

    public init(symbols: [Symbol], interval: CandleInterval, limit: Int, startTime: Date? = nil, endTime: Date? = nil) {
        self.symbols = symbols
        self.interval = interval
        self.limit = limit
        self.startTime = startTime
        self.endTime = endTime
    }
}
