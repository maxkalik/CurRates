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
    
    var generalCurrency: GeneralCurrency = .USD
    
    private enum CodingKeys: String, CodingKey {
        case id, description, reverseUsdQuot, rates
    }
}

extension Currency {
    enum RateAction: String {
        case sell
        case buy
    }
    
    enum RateType: String {
        case transfer
        case rate
    }
    
    typealias CurrencyType = (RateType, RateAction)
    
    func price(_ rateType: RateType, _ rateAction: RateAction) -> String {
        let i = self.generalCurrency == .USD ? 1 : 0
        let currencyType: CurrencyType = (rateType, rateAction)
        guard var price = getCurrency(currencyType, from: rates[i]) else { return "" }
        roundCurrency(&price)
        return price
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
    
    private func roundCurrency(_ value: inout String) {
        guard let floatValue = Float(value) else { return }
        value = String(format: "%.3f", reverseUsdQuot ? 1 / floatValue : floatValue)
    }
    
    mutating func updateGeneralCurrency(generalCurrency: GeneralCurrency) {
        self.generalCurrency = generalCurrency
    }
}
