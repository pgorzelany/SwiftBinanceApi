//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 17/11/2021.
//

import Foundation

public enum SymbolFilter {
    enum CodingKeys: String, CodingKey {
        case filterType
    }

    case price(PriceFilterPayload)
    case percentPrice(PercentPriceFilterPayload)
    case lotSize(LotSizeFilterPayload)
    case minimumNotional(MinimumNotionalFilterPayload)
    case icebergParts(IcebergPartsFilterPayload)
    case marketLotSize(MarketLotSizeFilterPayload)
    case maxNumberOfOrders(MaxNumberOfOrdersFilterPayload)
    case maxNumberOfAlgoOrders(MaxNumberOfAlgoOrdersFilterPayload)
    case maxNumberOfIcebergOrders(MaxNumberOfIcebergOrdersFilterPayload)
    case maxPosition(MaxPositionFilterPayload)
    case trailingDetla(TrailingDeltaFilterPayload)
}

extension SymbolFilter: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let filterType = try container.decode(SymbolFilterType.self, forKey: .filterType)
        switch filterType {
        case .price:
            let payload = try PriceFilterPayload(from: decoder)
            self = .price(payload)
        case .percentPrice:
            let payload = try PercentPriceFilterPayload(from: decoder)
            self = .percentPrice(payload)
        case .lotSize:
            let payload = try LotSizeFilterPayload(from: decoder)
            self = .lotSize(payload)
        case .minimumNotional:
            let payload = try MinimumNotionalFilterPayload(from: decoder)
            self = .minimumNotional(payload)
        case .icebergParts:
            let payload = try IcebergPartsFilterPayload(from: decoder)
            self = .icebergParts(payload)
        case .marketLotSize:
            let payload = try MarketLotSizeFilterPayload(from: decoder)
            self = .marketLotSize(payload)
        case .maxNumberOfOrders:
            let payload = try MaxNumberOfOrdersFilterPayload(from: decoder)
            self = .maxNumberOfOrders(payload)
        case .maxNumberOfAlgoOrders:
            let payload = try MaxNumberOfAlgoOrdersFilterPayload(from: decoder)
            self = .maxNumberOfAlgoOrders(payload)
        case .maxNumberOfIcebergOrders:
            let payload = try MaxNumberOfIcebergOrdersFilterPayload(from: decoder)
            self = .maxNumberOfIcebergOrders(payload)
        case .maxPosition:
            let payload = try MaxPositionFilterPayload(from: decoder)
            self = .maxPosition(payload)
        case .trailingDelta:
            let payload = try TrailingDeltaFilterPayload(from: decoder)
            self = .trailingDetla(payload)
        }
    }
}

public enum SymbolFilterType: String, Decodable {
    case price = "PRICE_FILTER"
    case percentPrice = "PERCENT_PRICE"
    case lotSize = "LOT_SIZE"
    case minimumNotional = "MIN_NOTIONAL"
    case icebergParts = "ICEBERG_PARTS"
    case marketLotSize = "MARKET_LOT_SIZE"
    case maxNumberOfOrders = "MAX_NUM_ORDERS"
    case maxNumberOfAlgoOrders = "MAX_NUM_ALGO_ORDERS"
    case maxNumberOfIcebergOrders = "MAX_NUM_ICEBERG_ORDERS"
    case maxPosition = "MAX_POSITION"
    case trailingDelta = "TRAILING_DELTA"
}

public struct PriceFilterPayload: Codable {
    public let minPrice: Decimal
    public let maxPrice: Decimal
    public let tickSize: Decimal
}

public struct PercentPriceFilterPayload: Codable {
    public let multiplierUp: Decimal
    public let multiplierDown: Decimal
    public let avgPriceMins: Int
}

public struct LotSizeFilterPayload: Codable {
    public let minQty: Decimal
    public let maxQty: Decimal
    public let stepSize: Decimal
}

public struct MinimumNotionalFilterPayload: Codable {
    public let minNotional: Decimal
    public let applyToMarket: Bool
    public let avgPriceMins: Int
}

public struct IcebergPartsFilterPayload: Codable {

}

public struct MarketLotSizeFilterPayload: Codable {

}

public struct MaxNumberOfOrdersFilterPayload: Codable {

}

public struct MaxNumberOfAlgoOrdersFilterPayload: Codable {

}

public struct MaxNumberOfIcebergOrdersFilterPayload: Codable {

}

public struct MaxPositionFilterPayload: Codable {
    public let maxPosition: Decimal
}

public struct TrailingDeltaFilterPayload: Codable {
}
