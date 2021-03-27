//
//  CurrencyDetailsViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import Foundation

class CurrencyDetailsViewModel {
    private let currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
    
    var id: String {
        return currency.id
    }
    
    var description: String {
        return currency.description
    }
    
    
}
