//
//  Currency.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import Foundation

struct Currency: Decodable {
    let id: String
    let description: String
    let reverseUsdQuot: Bool
    let rates: [Rate]
}
