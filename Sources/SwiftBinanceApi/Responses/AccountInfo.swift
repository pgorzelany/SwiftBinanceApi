//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 30/10/2021.
//

import Foundation

// MARK: - Welcome
public struct AccountInfo: ApiResponse {
    public let makerCommission, takerCommission, buyerCommission, sellerCommission: Int
    public let canTrade, canWithdraw, canDeposit: Bool
    public let updateTime: Date
    public let accountType: String
    public let balances: [Balance]
    public let permissions: [String]
}
