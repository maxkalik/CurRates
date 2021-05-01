//
//  Details.swift
//  CurRates
//
//  Created by Maksim Kalik on 4/29/21.
//

import Foundation

struct Details {
    var sell: String
    var buy: String
}

struct CurrencyDetails: Identifiable {
    let id = UUID()
    let title: Currency.Unit
    let transfer: Details
    let rate: Details
}
