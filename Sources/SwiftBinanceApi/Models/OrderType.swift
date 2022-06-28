//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 31/10/2021.
//

import Foundation

public enum OrderType: String, Codable {
    case limit = "LIMIT"
    case market = "MARKET"
    case limitMaker = "LIMIT_MAKER"
    case stopLimit = "STOP_LOSS"
    case stopLossLimit = "STOP_LOSS_LIMIT"
    case takeProfit = "TAKE_PROFIT"
    case takeProfitLimit = "TAKE_PROFIT_LIMIT"
}
