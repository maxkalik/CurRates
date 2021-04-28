//
//  Details.swift
//  CurRates
//
//  Created by Maksim Kalik on 4/29/21.
//

import Foundation

struct Details: Identifiable {
    var unitTitle: String
    var rateTypeTitle: String
    var sell: String
    var buy: String
    var id: UUID = UUID()
}
