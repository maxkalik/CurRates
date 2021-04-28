//
//  CurrencyViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import SwiftUI
import WidgetKit

enum CurrencyUnit: String, Equatable, CaseIterable {
    case EUR = "€"
    case USD = "$"
}

class CurrencyViewModel: Identifiable, ObservableObject {
    
    private(set) var isOnWidgetSelected = false
    
    @AppStorage(Constants.appStorageKey, store: UserDefaults(suiteName: Constants.suiteName)) var currencyData = Data()
    @Published private var currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
        isOnWidgetSelected = currency.id == getCurrencyId()
    }
}

extension CurrencyViewModel {
    
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
}

extension CurrencyViewModel {
    
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

extension CurrencyViewModel {

    func updateCurrencyUnit(_ currency: CurrencyUnit) {
        self.currency.updateCurrencyUnit(unit: currency)
    }
    
    func getCurrencyId() -> String {
        guard let id = try? JSONDecoder().decode(String.self, from: self.currencyData) else { return Constants.defaultCurencyOnWidget }
        return id
    }
    
    func showAtWidget(currencyId id: String) {
        guard let data = try? JSONEncoder().encode(id) else { return }
        currencyData = data
        WidgetCenter.shared.reloadTimelines(ofKind: "CurRatesWidget")
    }
}
