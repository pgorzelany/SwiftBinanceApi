//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 04/11/2021.
//


import Foundation

public struct SymbolPrice: Decodable {
    public let price: Decimal
    public let symbol: Symbol
}
