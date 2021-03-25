//
//  CurrencyViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import Foundation

struct CurrencyViewModel {
    
    /* Make here all calculation with reverseUSDQuot */
    
    let currency: Currency
    
    var id: String {
        return currency.id
    }
    
    var description: String {
        return currency.description
    }
    
    var sell: String {
        return currency.rates.first?.sellRate ?? "–"
    }
    
    var buy: String {
        return currency.rates.first?.buyRate ?? "–"
    }
}
