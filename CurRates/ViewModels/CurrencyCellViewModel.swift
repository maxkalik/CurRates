//
//  CurrencyCellViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import Foundation

struct CurrencyCellViewModel: Identifiable {
    
    private let currencyViewModel: CurrencyViewModel
    
    var id: String {
        return currency.id
    }
}
