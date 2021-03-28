//
//  CurrencyViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import Foundation

enum CurrencyUnit: String, Equatable, CaseIterable {
    case EUR = "€"
    case USD = "$"
}

class CurrencyViewModel: Identifiable, ObservableObject {
    
    struct Details: Identifiable {
        var unitTitle: String
        var rateTypeTitle: String
        var sell: String
        var buy: String
        var id: UUID = UUID()
    }
    
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
    
    var sell: String {
        return currency.price(.transfer, .sell)
    }
    
    var buy: String {
        return currency.price(.transfer, .buy)
    }
    
    func updateCurrencyUnit(_ currency: CurrencyUnit) {
        self.currency.updateCurrencyUnit(unit: currency)
    }
    
    var details: [Details] {
        return [
            Details(unitTitle: "USD",
                    rateTypeTitle: "Transfer",
                    sell: currency.price(.transfer, .sell, unit: .USD),
                    buy: currency.price(.transfer, .buy, unit: .USD)
            ),
            Details(unitTitle: "USD",
                    rateTypeTitle: "Rate",
                    sell: currency.price(.rate, .sell, unit: .USD),
                    buy: currency.price(.rate, .buy, unit: .USD)
            ),
            Details(unitTitle: "EUR",
                    rateTypeTitle: "Transfer",
                    sell: currency.price(.transfer, .sell, unit: .EUR),
                    buy: currency.price(.transfer, .buy, unit: .EUR)
            ),
            Details(unitTitle: "EUR",
                    rateTypeTitle: "Rate",
                    sell: currency.price(.rate, .sell, unit: .EUR),
                    buy: currency.price(.rate, .buy, unit: .EUR)
            )
        ]
    }
}
