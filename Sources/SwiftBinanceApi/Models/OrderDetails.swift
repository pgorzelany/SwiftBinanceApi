//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 02/11/2021.
//

import Foundation


public struct OrderDetails: Codable {
    public let symbol: Symbol
    public let orderId, orderListId: Int
    public let clientOrderId: String
    public let price, origQty, executedQty, cummulativeQuoteQty: Decimal
    public let status, timeInForce, type: String
    public let side: OrderSide
    public let stopPrice, icebergQty: Decimal
    public let time, updateTime: Date
    public let isWorking: Bool
    public let origQuoteOrderQty: Decimal
}
