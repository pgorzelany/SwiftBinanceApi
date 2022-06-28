//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 31/10/2021.
//

import Foundation

// MARK: - RateLimit
public struct RateLimit: Codable {
    public let rateLimitType, interval: String
    public let intervalNum, limit: Int
}
