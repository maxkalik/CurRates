//
//  Currency.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import Foundation

enum RateAction: String {
    case sell
    case buy
}

enum RateType: String {
    case transfer
    case rate
}

struct Currency: Decodable {
    let id: String
    let description: String
    let reverseUsdQuot: Bool
    let rates: [Rate]
    
    var unit: CurrencyUnit = .USD
    
    private enum CodingKeys: String, CodingKey {
        case id, description, reverseUsdQuot, rates
    }
}

extension Currency {
    typealias CurrencyType = (RateType, RateAction)
    
    func price(_ rateType: RateType, _ rateAction: RateAction, unit: CurrencyUnit? = nil) -> String {
        let currencyType: CurrencyType = (rateType, rateAction)
        if let currencyUnit = unit {
            let index = currencyUnit == .USD ? 1 : 0
            return getPrice(currencyType, rateIndex: index, currencyUnit: currencyUnit)
        } else {
            let index = self.unit == .USD ? 1 : 0
            return getPrice(currencyType, rateIndex: index, currencyUnit: self.unit)
        }
    }
    
    func getPrice(_ currencyType: CurrencyType, rateIndex: Int, currencyUnit: CurrencyUnit) -> String {
        guard let price = getCurrency(currencyType, from: rates[rateIndex]), let floatValue = Float(price) else { return "" }
        return String(format: "%.3f", reverseUsdQuot && currencyUnit == .USD ? 1 / floatValue : floatValue)
    }
    
    private func getCurrency(_ type: CurrencyType, from rate: Rate) -> String? {
        switch type {
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
    
    mutating func updateCurrencyUnit(unit: CurrencyUnit) {
        self.unit = unit
    }
}
