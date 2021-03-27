//
//  CurrencyViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import Foundation

struct CurrencyViewModel: Identifiable {
    
    /* Make here all calculation with reverseUSDQuot */
    
    let currency: Currency
    var generalCurrency: String
    
    init(currency: Currency) {
        self.currency = currency
        self.generalCurrency = "USD"
    }
    
    var id: String {
        return currency.id
    }
    
    var description: String {
        return currency.description
    }
    
    var sell: String {
        let index = generalCurrency == "EUR" ? 0 : 1
        if currency.reverseUsdQuot {
            return reverseDomesticFrom(usd: currency.rates[index].sellTransfer)
        }
        return roundCurrency(currency.rates[index].sellTransfer)
    }
    
    var buy: String {
        let index = generalCurrency == "EUR" ? 0 : 1
        if currency.reverseUsdQuot {
            return reverseDomesticFrom(usd: currency.rates[index].buyTransfer)
        }
        return roundCurrency(currency.rates[index].buyTransfer)
    }
    
    // func currencyRates(_ rates: [Rate]) -> String {
    //
    // }
    
    func roundCurrency(_ value: String?) -> String {
        guard let strValue = value, let floatValue = Float(strValue) else { return "" }
        return String(format: "%.3f", floatValue)
    }
    
    func reverseDomesticFrom(usd value: String?) -> String {
        guard let strValue = value, let floatValue = Float(strValue) else { return "" }
        return String(format: "%.3f", 1 / floatValue)
    }
    
    mutating func updateGeneralCurrency(_ currency: String) {
        self.generalCurrency = currency
    }
}
