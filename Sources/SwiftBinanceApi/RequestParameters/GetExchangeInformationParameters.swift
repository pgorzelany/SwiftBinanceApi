//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 31/10/2021.
//

import Foundation


public struct GetExchangeInformationParameters: RequestParameters {

    public let symbols: Symbol

    public init(symbols: [Symbol]) {
        self.symbols = ##"["\##(symbols.joined(separator: #"",""#))"]"##
    }
}
