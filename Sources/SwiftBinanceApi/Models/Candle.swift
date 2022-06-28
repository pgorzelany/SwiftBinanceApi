//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 01/11/2021.
//

import Foundation

public struct Candle: Codable {
    
    // MARK: Properties
    
    public let openTime: Date
    public let open: Decimal
    public let high: Decimal
    public let low: Decimal
    public let close: Decimal
    public let volume: Decimal
    public let closeTime: Date
    
    public var percentChange: Decimal {
        return (close / open) - 1
    }
    
    // MARK: Lifecycle
    
    init(openTime: Date, open: Decimal, high: Decimal, low: Decimal, close: Decimal, volume: Decimal, closeTime: Date) {
        self.openTime = openTime
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
        self.closeTime = closeTime
    }

    #warning("make sure the parsing is correct and make tests")
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.openTime = try container.decode(Date.self)
        self.open = try container.decode(Decimal.self)
        self.high = try container.decode(Decimal.self)
        self.low = try container.decode(Decimal.self)
        self.close = try container.decode(Decimal.self)
        self.volume = try container.decode(Decimal.self)
        self.closeTime = try container.decode(Date.self)
    }
    
    // MARK: Methods
    
    public func updateWithCurrentPrice(_ price: Decimal) -> Candle {
        let close = price
        let low = min(low, price)
        let high = max(high, price)
        #warning("volume is artificial here")
        return Candle(openTime: openTime, open: open, high: high, low: low, close: close, volume: volume, closeTime: closeTime)
    }
}
