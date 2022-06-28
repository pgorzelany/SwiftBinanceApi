//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 03/11/2021.
//

import Foundation


public struct OrderAcknowledged: Codable {
    public let symbol: Symbol
    public let orderId, orderListId: Int
    public let clientOrderId: String
    public let transactTime: Int
}
