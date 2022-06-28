//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 02/12/2021.
//

import Foundation


public struct BalanceConverter {
    
    // MARK: Lifecycle
    
    public init() {}
    
    // MARK: Methods
    
    public func convert(balances: [Balance], to conversionAsset: Asset, prices: [Symbol: Decimal]) -> [Asset: ConvertedBalance] {
        var results = [Symbol: ConvertedBalance]()
        for balance in balances {
            guard let exchangeRate = findExchangeRate(for: balance.asset, conversionAsset: conversionAsset, prices: prices) else {
                continue
            }
            results[balance.asset] = ConvertedBalance(balance: balance, conversionAsset: conversionAsset, exchangeRate: exchangeRate)
        }
        
        return results
    }
    
    private func findExchangeRate(for asset: Asset, conversionAsset: Asset, prices: [Symbol: Decimal]) -> Decimal? {
        guard asset != conversionAsset else {
            return 1.0
        }

        if let exchangeRate = prices["\(asset)\(conversionAsset)"] {
            return exchangeRate
        } else if let invertedExchangeRate = prices["\(conversionAsset)\(asset)"] {
            return 1 / invertedExchangeRate
        } else {
            return nil
        }
    }
}
