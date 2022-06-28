//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 29/10/2021.
//

import Foundation

public extension URL {
    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return absoluteURL
        }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        // a fix for a special case of encoding + in query parameters
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = urlComponents.url else {
            fatalError("The url should be constructed")
        }
        return url
    }
}
