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
    var generalCurrency: GeneralCurrency
    
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
        return currencyPrice(.sell)
    }
    
    var buy: String {
        return currencyPrice(.buy)
    }
    
    private enum Transfer: String {
        case sell
        case buy
    }
    
    private func currencyPrice(_ transfer: Transfer) -> String {
        guard var price = getCurrencyPrice(transfer) else { return "" }
        if currency.reverseUsdQuot {
            reverseDomesticFrom(usd: &price)
        } else {
            roundCurrency(&price)
        }
        return price
    }
    
    private func getCurrencyPrice(_ transfer: Transfer) -> String? {
        let index = generalCurrency == .USD ? 1 : 0
        
        switch transfer {
        case .buy:
            return currency.rates[index].sellTransfer
        case .sell:
            return currency.rates[index].buyRate
        }
    }
    
    private func roundCurrency(_ value: inout String) {
        guard let floatValue = Float(value) else { return }
        value = String(format: "%.3f", floatValue)
    }
    
    private func reverseDomesticFrom(usd value: inout String) {
        guard let floatValue = Float(value) else { return }
        value = String(format: "%.3f", 1 / floatValue)
    }
    
    mutating func updateGeneralCurrency(_ currency: GeneralCurrency) {
        self.generalCurrency = currency
    }
}
