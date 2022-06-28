//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 31/10/2021.
//

import Foundation

public enum OrderStatus: String {
    case new = "NEW"
    case partiallyFilled = "PARTIALLY_FILLED"
    case filled = "FILLED"
    case canceled = "CANCELED"
    case pendingCancel = "PENDING_CANCEL"
    case rejected = "REJECTED"
    case expired = "EXPIRED"
}
