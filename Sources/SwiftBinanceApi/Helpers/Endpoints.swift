//
//  File.swift
//  
//
//  Created by piotrg on 27/10/2021.
//

import Foundation

enum Endpoints {
    case ping
    case serverTime
    case accountInfo
    case testOrder
    case order
    case exchangeInformation
    case orderBook
    case orderBookTicker
    case candleStickData
    case openOrders
    case priceTicker
    case myTrades

    var path: String {
        let apiV3Prefix = "api/v3"
        switch self {
        case .ping:
            return "\(apiV3Prefix)/ping"
        case .serverTime:
            return "\(apiV3Prefix)/time"
        case .accountInfo:
            return "\(apiV3Prefix)/account"
        case .testOrder:
            return "\(apiV3Prefix)/order/test"
        case .order:
            return "\(apiV3Prefix)/order"
        case .exchangeInformation:
            return "\(apiV3Prefix)/exchangeInfo"
        case .orderBook:
            return "\(apiV3Prefix)/depth"
        case .orderBookTicker:
            return "\(apiV3Prefix)/ticker/bookTicker"
        case .candleStickData:
            return "\(apiV3Prefix)/klines"
        case .openOrders:
            return "\(apiV3Prefix)/openOrders"
        case .priceTicker:
            return "\(apiV3Prefix)/ticker/price"
        case .myTrades:
            return "\(apiV3Prefix)/myTrades"
        }
    }
}
