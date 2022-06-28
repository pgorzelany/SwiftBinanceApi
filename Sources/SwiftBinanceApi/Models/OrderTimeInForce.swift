//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 03/11/2021.
//

import Foundation

public enum OrderTimeInForce: String, Codable {
    /// An order will be on the book unless the order is canceled.
    case goodTillCanceled = "GTC"

    /// An order will try to fill the order as much as it can before the order expires.
    case immediateOrCancel = "IOC"

    /// An order will expire if the full order cannot be filled upon execution.
    case fillOrKill = "FOK"
}
