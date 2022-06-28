//
//  File.swift
//  
//
//  Created by Piotr Gorzelany on 05/11/2021.
//

import Foundation

class BinanceJsonEncoder: JSONEncoder {

    override init() {
        super.init()
        dateEncodingStrategy = .custom({ date, encoder in
            var container = encoder.singleValueContainer()
            let dateAsMilissecondsSince1970 = Int(date.timeIntervalSince1970 * 1000.0)
            try container.encode(dateAsMilissecondsSince1970)
        })
    }
}
