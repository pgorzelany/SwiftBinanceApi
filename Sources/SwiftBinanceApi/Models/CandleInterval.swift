//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 03/11/2021.
//

import Foundation

public enum CandleInterval: String, Codable {
    case _1m = "1m"
    case _5m = "5m"
    case _15m = "15m"
    case _30m = "30m"
    case _1h = "1h"
    case _2h = "2h"
    case _4h = "4h"
    case _1d = "1d"
    case _1w = "1w"
    case _1M = "1M"
}
