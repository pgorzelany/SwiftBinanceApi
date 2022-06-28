//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 09/06/2022.
//

import Foundation

public enum SymbolStatus: String, Codable {
    case preTrading = "PRE_TRADING"
    case trading = "TRADING"
    case postTrading = "POST_TRADING"
    case endOfDay = "END_OF_DAY"
    case halt = "HALT"
    case auctionMatch = "AUCTION_MATCH"
    case `break` = "BREAK"
}
