//
//  File.swift
//  
//
//  Created by piotrg on 27/10/2021.
//

import Foundation

class BinanceJsonDecoder: JSONDecoder {

    override init() {
        super.init()
        dateDecodingStrategy = .millisecondsSince1970
    }
}
