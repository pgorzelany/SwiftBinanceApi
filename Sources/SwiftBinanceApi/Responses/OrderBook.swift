//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 01/11/2021.
//

import Foundation

public struct OrderBook: ApiResponse {
    public let lastUpdateId: Int
    public let bids: [OrderBookBid]
    public let asks: [OrderBookAsk]
}
