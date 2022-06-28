//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 30/10/2021.
//

import Foundation

// MARK: - Balance
public struct Balance: Codable {
    public let asset: String
    public let free: Decimal
    public let locked: Decimal

    public var total: Decimal {
        return free + locked
    }
}
