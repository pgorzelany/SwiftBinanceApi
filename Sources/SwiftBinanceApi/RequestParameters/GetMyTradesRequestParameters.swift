//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 05/11/2021.
//


import Foundation

public struct GetMyTradesRequestParameters: RequestParameters {

    public let symbol: Symbol
    public let startTime: Date?
    public let endTime: Date?
    public let limit: Int?

    public init(symbol: Symbol, startTime: Date? = nil, endTime: Date? = nil, limit: Int? = nil) {
        self.symbol = symbol
        self.startTime = startTime
        self.endTime = endTime
        self.limit = limit
    }
}
