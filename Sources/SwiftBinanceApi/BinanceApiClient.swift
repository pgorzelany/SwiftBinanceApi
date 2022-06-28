//
//  File.swift
//  
//
//  Created by piotrg on 27/10/2021.
//

import Foundation

public protocol BinanceApiClientProtocol {
    func ping() async throws -> Void
    func checkServerTime() async throws -> ServerTime
    func getAccountInformation() async throws -> AccountInfo
    func getExchangeInfo(params: GetExchangeInformationParameters?) async throws -> ExchangeInfo
    func getOrderBook(params: GetOrderBookRequestParameters) async throws -> OrderBook
    func getOrderBookTickers() async throws -> [Symbol: OrderBookTicker]
    func getCandleStickData(params: GetCandleStickDataRequestParameters) async throws -> [Candle]
    func getCandleStickDataForSymbols(params: GetCandleStickDataForSymbolsRequestParameters) async throws -> [Symbol: [Candle]]
    func getOpenOrders(params: GetOpenOrderRequestParameters?) async throws -> [OrderDetails]
    func cancelOpenOrdersForSymbol(params: CancelOpenOrdersRequestParameters) async throws -> [Order]
    func cancelOpenOrdersForSymbols(symbols: [Symbol]) async throws -> [Order]
    func cancelAllOpenOrders() async throws -> [Order]
    func cancelOrder(params: CancelOrderRequestParameters) async throws -> Order
    func cancelOrders(params: [CancelOrderRequestParameters]) async throws -> [Order]
    func testOrder(params: NewOrderRequestParameters) async throws -> Void
    func newOrder(params: NewOrderRequestParameters) async throws -> OrderAcknowledged
    func getCurrentPrices() async throws -> [Symbol: Decimal]
    func getMyTrades(params: GetMyTradesRequestParameters) async throws -> [Trade]
}

/// A lower level network class for making request. All network trafic will go through this class
public actor BinanceApiClient {

    public enum Environment {
        case test
        case prod
    }

    // MARK: Properties

    private let urlSession = URLSession(configuration: .default)
    private let backendUrl: URL
    private let secretKey: String
    private let apiKey: String
    private let debugRequests: Bool
    private let debugResponses: Bool
    private let requestSigner: RequestSigner
    private let requestCreator: URLRequestCreator

    // MARK: Lifecycle

    public init(environment: Environment,
                apiKey: String,
                secretKey: String,
                debugRequests: Bool,
                debugResponses: Bool) {
        switch environment {
        case .test:
            backendUrl = URL(string: "https://testnet.binance.vision")!
        case .prod:
            backendUrl = URL(string: "https://api.binance.com")!
        }
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.debugRequests = debugRequests
        self.debugResponses = debugResponses
        self.requestSigner = RequestSigner(secretKey: secretKey)
        self.requestCreator = URLRequestCreator(apiKey: apiKey, requestSigner: requestSigner)
    }

    // MARK: Methods
    
    private func performDataRequest(_ request: ApiRequest) async throws -> Data {
        let urlRequest = requestCreator.createUrlRequest(from: request)
        let (data, response) = try await urlSession.data(for: urlRequest)
        try validateResponse(response, data: data)
        return data
    }
    
    private func validateResponse(_ response: URLResponse, data: Data) throws {
        let response = response as! HTTPURLResponse
        guard (200..<300).contains(response.statusCode) else {
            #warning("Consider throwing a custom error here")
            let binanceError = try? BinanceJsonDecoder().decode(ErrorResponse.self, from: data)
            throw binanceError ?? NSError(domain: "Api", code: 0, userInfo: nil)
        }
    }

    private func performDecodableRequest<Response: Decodable>(_ request: ApiRequest, debug: Bool = false) async throws -> Response {
        let data = try await performDataRequest(request)
        if debug {
            print(String(data: data, encoding: .utf8) ?? "")
        }
        let decodedResponse = try BinanceJsonDecoder().decode(Response.self, from: data)
        return decodedResponse
    }

    private func performCompletableRequest(_ request: ApiRequest) async throws -> Void {
        let _ = try await performDataRequest(request)
        return
    }
}

extension BinanceApiClient: BinanceApiClientProtocol {

    public func ping() async throws {
        let url = backendUrl.appendingPathComponent(Endpoints.ping.path)
        return try await performCompletableRequest(ApiRequest(method: .get, url: url, security: .none))
    }

    public func checkServerTime() async throws -> ServerTime {
        let url = backendUrl.appendingPathComponent(Endpoints.serverTime.path)
        return try await performDecodableRequest(ApiRequest(method: .get, url: url, security: .none))
    }

    public func getAccountInformation() async throws -> AccountInfo {
        let url = backendUrl.appendingPathComponent(Endpoints.accountInfo.path)
        let accountInfo: AccountInfo = try await performDecodableRequest(ApiRequest(method: .get, url: url, security: .signed))
        let nonEmptyBalances = accountInfo.balances.filter({ $0.total != 0 })
        return AccountInfo(makerCommission: accountInfo.makerCommission, takerCommission: accountInfo.takerCommission, buyerCommission: accountInfo.buyerCommission, sellerCommission: accountInfo.sellerCommission, canTrade: accountInfo.canTrade, canWithdraw: accountInfo.canWithdraw, canDeposit: accountInfo.canDeposit, updateTime: accountInfo.updateTime, accountType: accountInfo.accountType, balances: nonEmptyBalances, permissions: accountInfo.permissions)
    }

    public func getExchangeInfo(params: GetExchangeInformationParameters?) async throws -> ExchangeInfo {
        let url = backendUrl.appendingPathComponent(Endpoints.exchangeInformation.path)
        return try await performDecodableRequest(ApiRequest(method: .get, url: url, parameters: try? params?.toDictionary(), security: .none))
    }

    public func getOrderBook(params: GetOrderBookRequestParameters) async throws -> OrderBook {
        let url = backendUrl.appendingPathComponent(Endpoints.orderBook.path)
        return try await performDecodableRequest(ApiRequest(method: .get, url: url, parameters: try? params.toDictionary(), security: .none))
    }

    public func getOrderBookTickers() async throws -> [Symbol: OrderBookTicker] {
        let url = backendUrl.appendingPathComponent(Endpoints.orderBookTicker.path)
        let orderBookTickers: [OrderBookTicker] = try await performDecodableRequest(ApiRequest(method: .get, url: url, security: .none))
        return Dictionary(uniqueKeysWithValues: orderBookTickers.map{ ($0.symbol, $0) })
    }

    public func getCandleStickData(params: GetCandleStickDataRequestParameters) async throws -> [Candle] {
        let url = backendUrl.appendingPathComponent(Endpoints.candleStickData.path)
        return try await performDecodableRequest(ApiRequest(method: .get, url: url, parameters: try? params.toDictionary(), security: .none))
    }

    public func getCandleStickDataForSymbols(params: GetCandleStickDataForSymbolsRequestParameters) async throws -> [Symbol : [Candle]] {
        return try await withThrowingTaskGroup(of: (Symbol, [Candle]).self, returning: [Symbol: [Candle]].self) { [weak self] taskGroup in
            guard let self = self else {
                return [:]
            }

            for symbol in params.symbols {
                taskGroup.addTask(priority: .high) {
                    let parameters = GetCandleStickDataRequestParameters(
                        symbol: symbol,
                        interval: params.interval,
                        limit: params.limit,
                        startTime: params.startTime,
                        endTime: params.endTime
                    )
                    let symbolCandles = (try? await self.getCandleStickData(params: parameters)) ?? []
                    return (symbol, symbolCandles)
                }
            }

            var results = [Symbol: [Candle]]()
            for try await result in taskGroup {
                results[result.0] = result.1
            }
            return results
        }
    }

    public func getOpenOrders(params: GetOpenOrderRequestParameters?) async throws -> [OrderDetails] {
        let url = backendUrl.appendingPathComponent(Endpoints.openOrders.path)
        return try await performDecodableRequest(ApiRequest(method: .get, url: url, parameters: try? params?.toDictionary(), security: .signed))
    }

    public func cancelOpenOrdersForSymbol(params: CancelOpenOrdersRequestParameters) async throws -> [Order] {
        let url = backendUrl.appendingPathComponent(Endpoints.openOrders.path)
        return try await performDecodableRequest(ApiRequest(method: .delete, url: url, parameters: try? params.toDictionary(), security: .signed))
    }
    
    public func cancelOpenOrdersForSymbols(symbols: [Symbol]) async throws -> [Order] {
        return try await withThrowingTaskGroup(of: [Order]?.self, returning: [Order].self) { [weak self] taskGroup in
            guard let self = self else {
                return []
            }
            
            for symbol in symbols {
                taskGroup.addTask(priority: .high) {
                    #warning("if this fails to cancel an order, we may have an invalid view of the world")
                    return try? await self.cancelOpenOrdersForSymbol(params: CancelOpenOrdersRequestParameters(symbol: symbol))
                }
            }
            
            return try await taskGroup.compactMap({ $0 }).reduce([], +)
        }
    }

    public func cancelAllOpenOrders() async throws -> [Order] {
        let openOrders = try await getOpenOrders(params: nil)
        let symbolsWithOpenOrders = Set(openOrders.map(\.symbol))
        return try await withThrowingTaskGroup(of: [Order].self, returning: [Order].self) { taskGroup in
            var results = [Order]()
            for symbol in symbolsWithOpenOrders {
                taskGroup.addTask { [weak self] in
                    guard let self = self else {
                        return []
                    }
                    return try await self.cancelOpenOrdersForSymbol(params: CancelOpenOrdersRequestParameters(symbol: symbol))
                }
            }

            for try await cancelledOrders in taskGroup {
                results += cancelledOrders
            }

            return results
        }
    }

    public func cancelOrder(params: CancelOrderRequestParameters) async throws -> Order {
        let url = backendUrl.appendingPathComponent(Endpoints.order.path)
        return try await performDecodableRequest(ApiRequest(method: .delete, url: url, parameters: try? params.toDictionary(), security: .signed))
    }

    /// Place cancel orders in parallel
    public func cancelOrders(params: [CancelOrderRequestParameters]) async throws -> [Order] {
        return try await withThrowingTaskGroup(of: Order.self, returning: [Order].self) { [weak self] taskGroup in
            guard let self = self else {
                return []
            }
            var results = [Order]()
            for cancelOrderParameters in params {
                taskGroup.addTask {
                    try await self.cancelOrder(params: cancelOrderParameters)
                }
            }

            for try await order in taskGroup {
                results.append(order)
            }
            return results
        }
    }

    public func testOrder(params: NewOrderRequestParameters) async throws {
        let url = backendUrl.appendingPathComponent(Endpoints.testOrder.path)
        return try await performCompletableRequest(ApiRequest(method: .post, url: url, parameters: try? params.toDictionary(), security: .signed))
    }

    public func newOrder(params: NewOrderRequestParameters) async throws -> OrderAcknowledged {
        let url = backendUrl.appendingPathComponent(Endpoints.order.path)
        return try await performDecodableRequest(ApiRequest(method: .post, url: url, parameters: try? params.toDictionary(), security: .signed))
    }

    public func getCurrentPrices() async throws -> [Symbol: Decimal] {
        let url = backendUrl.appendingPathComponent(Endpoints.priceTicker.path)
        let prices: [SymbolPrice] = try await performDecodableRequest(ApiRequest(method: .get, url: url, security: .none))
        return Dictionary(uniqueKeysWithValues: prices.map({ return ($0.symbol, $0.price) }))
    }

    public func getMyTrades(params: GetMyTradesRequestParameters) async throws -> [Trade] {
        let url = backendUrl.appendingPathComponent(Endpoints.myTrades.path)
        return try await performDecodableRequest(ApiRequest(method: .get, url: url, parameters: try? params.toDictionary(), security: .signed))
    }
}
