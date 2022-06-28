//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 02/11/2021.
//

import Foundation


public struct Order: Codable {
    public let symbol: Symbol
    public let orderId, orderListId: Int
    public let origClientOrderId, clientOrderId: String
    public let price, origQty, executedQty, cummulativeQuoteQty: Decimal
    public let status, timeInForce, type, side: String
}
