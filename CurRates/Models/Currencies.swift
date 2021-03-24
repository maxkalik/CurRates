//
//  ResponseData.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import Foundation

struct Currencies: Decodable {
    let data: [Currency]
    let success: Bool
    let invalidated: Bool
}
