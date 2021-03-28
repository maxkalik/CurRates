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

class CurrencyViewModel: Identifiable, ObservableObject {
    
    @Published private var currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
    
    var id: String {
        return currency.id
    }
    
    var description: String {
        return currency.description
    }
    
    var transferSell: String {
        return currency.price(.transfer, .sell)
    }
    
    var transferBuy: String {
        return currency.price(.transfer, .buy)
    }
    
    var rateSell: String {
        return currency.price(.rate, .sell)
    }
    
    var rateBuy: String {
        return currency.price(.rate, .buy)
    }
    
    func updateGeneralCurrency(_ currency: GeneralCurrency) {
        self.currency.updateGeneralCurrency(generalCurrency: currency)
    }
}
