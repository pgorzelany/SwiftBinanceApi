//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 28/06/2022.
//

import Foundation

public extension Decimal {
    func stringValue() -> String {
        return NSDecimalNumber(decimal: self).stringValue
    }
}
