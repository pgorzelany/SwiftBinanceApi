//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 02/11/2021.
//


import Foundation

public struct OrderBookTicker: Codable {
    public let symbol: Symbol
    public let bidPrice, bidQty, askPrice, askQty: Decimal
}
