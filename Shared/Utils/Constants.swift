//
//  Constaints.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import Foundation

struct Constants {
    static let baseUrl                 = "https://m.citadele.lv/cimo/p/currate"
    static let suiteName               = "group.maxkalik.com.CurRates.Currencies"
    static let widgetKind              = "CurRatesWidget"
    static let appStorageKey           = "currency"
    static let defaultCurrencyOnWidget = "RUR"
    static let emptyValue              = "•••"
}

struct Settings {
    static let currency: Currency.Unit = .EUR
}
