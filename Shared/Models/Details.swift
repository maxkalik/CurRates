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
    
    
    enum CurrencyTitle: String {
        case EUR = "EUR"
        case USD = "USD"
    }
    
    let id = UUID()
    let title: CurrencyTitle
    let transfer: Details
    let rate: Details
}
