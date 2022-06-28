//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 02/12/2021.
//

import Foundation


public struct ConvertedBalance {
    public let asset: Asset
    public let free: Decimal
    public let locked: Decimal
    public let conversionAsset: Asset
    public let exchangeRate: Decimal
    
    public var total: Decimal {
        return free + locked
    }

    public var freeInConversionAsset: Decimal {
        return free * exchangeRate
    }

    public var lockedInConversionAsset: Decimal {
        return locked * exchangeRate
    }

    public var totalInConversionAsset: Decimal {
        return total * exchangeRate
    }

    init(balance: Balance, conversionAsset: Asset, exchangeRate: Decimal) {
        self.asset = balance.asset
        self.free = balance.free
        self.locked = balance.locked
        self.conversionAsset = conversionAsset
        self.exchangeRate = exchangeRate
    }
}

extension ConvertedBalance: CustomStringConvertible {
    public var description: String {
        return "\(asset): \(totalInConversionAsset)\(conversionAsset)"
    }
}

extension Array where Element == ConvertedBalance {
    public func toDictionary() -> [Asset: ConvertedBalance] {
        let zipped = self.map({ ($0.asset, $0) })
        return Dictionary.init(uniqueKeysWithValues: zipped)
    }
}
