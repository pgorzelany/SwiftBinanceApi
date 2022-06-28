//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 29/12/2021.
//

import Foundation

final class URLRequestCreator {
    
    // MARK: Properties
    
    let apiKey: String
    let requestSigner: RequestSigner
    
    // MARK: Lifecyle
    
    init(apiKey: String, requestSigner: RequestSigner) {
        self.apiKey = apiKey
        self.requestSigner = requestSigner
    }
    
    // MARK: Methods
    
    func createUrlRequest(from apiRequest: ApiRequest) -> URLRequest {
        var components = URLComponents(url: apiRequest.url, resolvingAgainstBaseURL: false)!
        var queryItems = [URLQueryItem]()
        for (name, value) in apiRequest.parameters ?? [:] {
            #warning("check that the value is a simple type like int or string and not an object")
            let queryItem = URLQueryItem(name: name, value: "\(value)")
            queryItems.append(queryItem)
        }
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = apiRequest.method.rawValue
        adapt(&request, securityLevel: apiRequest.security)
        return request
    }
    
    func adapt(_ request: inout URLRequest, securityLevel: RequestSecurityLevel) {
        request.timeoutInterval = 5.0
        switch securityLevel {
        case .none:
            break
        case .apiKey:
            addApiKeyHeader(&request)
        case .signed:
            signRequest(&request)
        }
    }
    
    private func addApiKeyHeader(_ request: inout URLRequest) -> Void {
        request.addValue(apiKey, forHTTPHeaderField: "X-MBX-APIKEY")
    }

    private func signRequest(_ request: inout URLRequest) -> Void {
        addApiKeyHeader(&request)
        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        request.url = request.url?.appending("timestamp", value: "\(timestamp)")
        guard let query = request.url?.query else {
            fatalError("query should be here!")
        }
        let signature = requestSigner.getHmacSignature(for: query)
        request.url = request.url?.appending("signature", value: signature)
    }
}
