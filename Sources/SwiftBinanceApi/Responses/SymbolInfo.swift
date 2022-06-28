//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 31/10/2021.
//

import Foundation


public struct SymbolInfo: Decodable {
    public let symbol: Symbol
    public let status: SymbolStatus
    public let baseAsset: String
    public let baseAssetPrecision: Int
    public let quoteAsset: String
    public let quotePrecision, quoteAssetPrecision, baseCommissionPrecision, quoteCommissionPrecision: Int
    public let orderTypes: [OrderType]
    public let icebergAllowed, ocoAllowed, quoteOrderQtyMarketAllowed, isSpotTradingAllowed: Bool
    public let isMarginTradingAllowed: Bool
    public let filters: [SymbolFilter]
    public let permissions: [String]

    public var lotSizeFilter: LotSizeFilterPayload {
        return filters.compactMap { filter -> LotSizeFilterPayload? in
            if case let .lotSize(payload) = filter {
                return payload
            }
            return nil
        }.first!
    }

    public var priceFilter: PriceFilterPayload {
        return filters.compactMap { filter -> PriceFilterPayload? in
            if case let .price(payload) = filter {
                return payload
            }
            return nil
        }.first!
    }
    
    public var minNotionalFilter: MinimumNotionalFilterPayload {
        return filters.compactMap { filter -> MinimumNotionalFilterPayload? in
            if case let .minimumNotional(payload) = filter {
                return payload
            }
            return nil
        }.first!
    }
    
    public var maxPositionFilter: MaxPositionFilterPayload {
        return filters.compactMap { filter -> MaxPositionFilterPayload? in
            if case let .maxPosition(payload) = filter {
                return payload
            }
            return nil
        }.first!
    }

    public var quantityRoundingPrecision: Int {
        return (Decimal(1) / lotSizeFilter.stepSize).stringValue().filter({ $0 == "0" }).count
    }
    
    public var priceRoundingPrecision: Int {
        return (Decimal(1) / priceFilter.tickSize).stringValue().filter({ $0 == "0" }).count
    }
}
