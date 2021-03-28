//
//  Rate.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import Foundation

struct Rate: Decodable {
    let currency: String
    let description: String
    let sellRate: String?
    let buyRate: String?
    let sellTransfer: String?
    let buyTransfer: String?
}
