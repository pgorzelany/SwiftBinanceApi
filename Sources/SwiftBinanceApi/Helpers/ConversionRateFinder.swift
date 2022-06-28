//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 02/06/2022.
//

import Foundation


#warning("Does not work in its current state")
public struct CurrencyPair: Equatable, Hashable {
    public let first: String
    public let second: String

    public init(first: String, second: String) {
        self.first = first
        self.second = second
    }

    public init(symbol: Symbol) {
        guard symbol.count == 6 else {
            fatalError("Invalid currency pair format")
        }
        self.first = String(symbol.map{ $0 }[0...2].map(String.init).joined())
        self.second = String(symbol.map{ $0 }[3...].map(String.init).joined())
    }

    public func contains(asset: Asset) -> Bool {
        return [first, second].contains(asset)
    }
}

public struct ConversionRateFinder {

    // MARK: Properties

    private var cache = [CurrencyPair: [CurrencyPair]]()

    // MARK: Lifecycle

    public init() {}

    // MARK: Methods

    public mutating func findRateAndRoute(for currencyPair: Symbol, rates: [Symbol: Decimal]) -> (rate: Decimal, route: String) {
        cache = [:]
        let originalCurrencyPair = CurrencyPair(symbol: currencyPair)
        let allPairs = rates.keys.map(CurrencyPair.init)
        let shortesRoute = findShortestRoute(for: originalCurrencyPair, allPairs: allPairs)
        let rates = Dictionary(uniqueKeysWithValues: rates.map({ (CurrencyPair(symbol: $0.key), $0.value) }))
        return (rate: getRate(for: shortesRoute, rates: rates), route: getString(describing: shortesRoute))
    }

    mutating func findShortestRoute(for currencyPair: CurrencyPair, allPairs: [CurrencyPair]) -> [CurrencyPair] {
        if let route = cache[currencyPair] {
            return route
        }
        if allPairs.contains(currencyPair) {
            cache[currencyPair] = [currencyPair]
            return [currencyPair]
        }

        let first = currencyPair.first
        let pairsContainingFirst = allPairs.filter( { $0.first == first } ).filter({ $0.first != $0.second })
        var routes = [[CurrencyPair]]()
        for pairContainingFirst in pairsContainingFirst {
            let allPairs = allPairs.filter({ $0 != pairContainingFirst })
            let route = [pairContainingFirst] + findShortestRoute(for: CurrencyPair(first: pairContainingFirst.second, second: currencyPair.second), allPairs: allPairs)
            routes.append(route)
        }
        let shortestRoute = routes
            .filter({ $0.last?.second == currencyPair.second })
            .min(by: { $0.count < $1.count }) ?? []
        cache[currencyPair] = shortestRoute
        return shortestRoute
    }


    func getString(describing route: [CurrencyPair]) -> String {
        var results = ""
        for currencyPair in route {
            if currencyPair == route.last {
                results += (currencyPair.first + currencyPair.second)
                continue
            }
            results += currencyPair.first
        }
        return results
    }

    func getRate(for route: [CurrencyPair], rates: [CurrencyPair: Decimal]) -> Decimal {
        var results: Decimal = 1
        for currencyPair in route {
            guard let rate = rates[currencyPair] else {
                fatalError("Rate should be present")
            }
            results *= rate
        }
        return results
    }
}
