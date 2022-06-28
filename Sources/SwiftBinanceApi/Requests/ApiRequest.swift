//
//  File.swift
//  
//
//  Created by piotrg on 27/10/2021.
//

import Foundation

struct ApiRequest {
    let method: HTTPMethod
    let url: URL
    let parameters: [String: Any]?
    var headers: [String: String]?
    var security: RequestSecurityLevel

    init(method: HTTPMethod,
                url: URL,
                parameters: [String : Any]? = nil,
                headers: [String: String]? = nil,
                security: RequestSecurityLevel) {
        self.method = method
        self.url = url
        self.parameters = parameters
        self.headers = headers
        self.security = security
    }
}
