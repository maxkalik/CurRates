//
//  Details.swift
//  CurRates
//
//  Created by Maksim Kalik on 4/29/21.
//

import Foundation

struct CurrencyDetailsModelView: Identifiable {
    let id = UUID()
    let title: Currency.Unit
    let transfer: Currency.Details
    let rate: Currency.Details
    
    init(unit: Currency.Unit, currency: Currency) {
        self.title = unit
        self.transfer = Currency.Details(sell: currency.price(.transfer, .sell, unit: unit), buy: currency.price(.transfer, .buy, unit: unit))
        self.rate = Currency.Details(sell: currency.price(.rate, .sell, unit: unit), buy: currency.price(.rate, .buy, unit: unit))
    }
}
