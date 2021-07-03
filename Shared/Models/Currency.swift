//
//  Currency.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import Foundation

struct Currency: Decodable {
    
    let id: String
    let description: String
    let reverseUsdQuot: Bool
    let rates: [Rate]
    var unit: Unit = Settings.currency
    
    struct Details {
        var sell: String
        var buy: String
    }
    
    enum RateAction: String {
        case sell
        case buy
    }

    enum RateType: String {
        case transfer
        case rate
    }
    
    enum Unit: String, Equatable, CaseIterable {
        case EUR = "€"
        case USD = "$"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, description, reverseUsdQuot, rates
    }
}

extension Currency {
    private typealias CurrencyType = (RateType, RateAction)
    
    func price(_ rateType: RateType, _ rateAction: RateAction, unit: Unit? = nil) -> String {
        let currencyType: CurrencyType = (rateType, rateAction)
        let rateIndex = getRateIndex(from: unit ?? self.unit)
        return getPrice(currencyType, rateIndex: rateIndex, currencyUnit: self.unit)
    }
    
    private func getRateIndex(from currencyUnit: Currency.Unit) -> Int {
        return currencyUnit == .USD ? 1 : 0
    }
    
    private func getPrice(_ currencyType: CurrencyType, rateIndex: Int, currencyUnit: Unit) -> String {
        guard let price = getCurrency(currencyType, from: rates[rateIndex]), let floatValue = Float(price) else { return "" }
        return String(format: "%.3f", reverseUsdQuot && currencyUnit == .USD ? 1 / floatValue : floatValue)
    }
    
    private func getCurrency(_ currencyType: CurrencyType, from rate: Rate) -> String? {
        switch currencyType {
        case (.rate, .buy):
            return rate.buyRate
        case (.rate, .sell):
            return rate.sellRate
        case (.transfer, .buy):
            return rate.buyTransfer
        case (.transfer, .sell):
            return rate.sellTransfer
        }
    }
    
    mutating func updateCurrencyUnit(unit: Unit) {
        self.unit = unit
    }
}
