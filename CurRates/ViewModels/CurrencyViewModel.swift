//
//  CurrencyViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import Foundation

enum GeneralCurrency: String, Equatable, CaseIterable {
    case EUR = "€"
    case USD = "$"
}

struct CurrencyViewModel: Identifiable {
    
    private let currency: Currency
    private var generalCurrency: GeneralCurrency
    
    init(currency: Currency) {
        self.currency = currency
        self.generalCurrency = .USD
    }
    
    var id: String {
        return currency.id
    }
    
    var description: String {
        return currency.description
    }
    
    var sell: String {
        return currency.currencyPrice(.transfer, .sell, with: generalCurrency)
    }
    
    var buy: String {
        return currency.currencyPrice(.transfer, .buy, with: generalCurrency)
    }
    
    mutating func updateGeneralCurrency(_ currency: GeneralCurrency) {
        self.generalCurrency = currency
    }
}
