//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 05/11/2021.
//

import Foundation


public struct Trade: Codable {
    public let symbol: Symbol
    public let id, orderId, orderListId: Int
    public let price, qty, quoteQty, commission: Decimal
    public let commissionAsset: String
    public let time: Date
    public let isBuyer, isMaker, isBestMatch: Bool
}
