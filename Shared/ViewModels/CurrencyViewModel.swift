//
//  CurrencyViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import SwiftUI
import WidgetKit

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
    
    var details: [CurrencyDetailsViewModel] {
        let usd = CurrencyDetailsViewModel(unit: .USD, currency: currency)
        let eur = CurrencyDetailsViewModel(unit: .EUR, currency: currency)
        return [ usd, eur ]
    }
}

extension CurrencyViewModel {

    func updateCurrencyUnit(_ currency: Currency.Unit) {
        self.currency.updateCurrencyUnit(unit: currency)
    }
    
    func getCurrencyId() -> String {
        guard let id = try? JSONDecoder().decode(String.self, from: self.currencyData) else {
            return EnvironmentVariables.currencyOnWidget ?? Configuration.defaultCurrencyOnWidget
        }
        return id
    }
    
    func showAtWidget(currencyId id: String) {
        guard let data = try? JSONEncoder().encode(id) else { return }
        currencyData = data
        WidgetCenter.shared.reloadTimelines(ofKind: Constants.widgetKind)
    }
}
