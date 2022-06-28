//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 01/11/2021.
//


import Foundation

public struct GetCandleStickDataRequestParameters: RequestParameters {

    public let symbol: Symbol
    public let interval: CandleInterval
    public let limit: Int
    public let startTime: Date?
    public let endTime: Date?

    public init(symbol: Symbol, interval: CandleInterval, limit: Int, startTime: Date? = nil, endTime: Date? = nil) {
        self.symbol = symbol
        self.interval = interval
        self.limit = limit
        self.startTime = startTime
        self.endTime = endTime
    }
}
