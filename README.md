# SwiftBinanceApi

A Swift wrapper for the Binance Spot trading API.

## Supported endpoints

```
public protocol BinanceApiClientProtocol: AnyObject {
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
```

## Example Usage


```
let apiKey = "Your Binance api key"
let secretKey = "Your Binance seret key"
let api = BinanceApiClient(environment: .prod, apiKey: apiKey, secretKey: secretKey, debugRequests: false, debugResponses: false)

// get server time and account info

let serverTime = try await api.checkServerTime()
let accountInfo = try await api.getAccountInformation()

// place a buy order

let buyBtcOrder = NewOrderRequestParameters(symbol: "BTCBUSD", side: .buy, price: 20_000, quantity: 1.0)
let orderAcknowlegment = try await api.newOrder(params: buyBtcOrder)

//  cancel the order

let order = try await api.cancelOrder(params: CancelOrderRequestParameters(symbol: orderAcknowlegment.symbol, orderId: orderAcknowlegment.orderId))

// get historical prices

let params = GetCandleStickDataRequestParameters(symbol: "BTCBUSD", interval: ._1d, limit: 500)
let historicalData = try await api.getCandleStickData(params: params)
```
