//
//  CurrencyViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import SwiftUI
import WidgetKit
import CurRatesNetwork

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
    
    var details: [CurrencyDetailsModelView] {
        let eur = CurrencyDetailsModelView(unit: .EUR, currency: currency)
        let usd = CurrencyDetailsModelView(unit: .USD, currency: currency)
        return [ eur, usd ]
    }
}

extension CurrencyViewModel {

    func updateCurrencyUnit(_ currency: Currency.Unit) {
        self.currency.updateCurrencyUnit(unit: currency)
    }
    
    func getCurrencyId() -> String {
        guard let id = try? JSONDecoder().decode(String.self, from: self.currencyData) else { return Constants.defaultCurencyOnWidget }
        return id
    }
    
    func showAtWidget(currencyId id: String) {
        guard let data = try? JSONEncoder().encode(id) else { return }
        currencyData = data
        WidgetCenter.shared.reloadTimelines(ofKind: Constants.widgetKind)
    }
}
