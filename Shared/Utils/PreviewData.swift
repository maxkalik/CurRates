//
//  PreviewData.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import Foundation

extension Rate {
    static let eur = Rate(currency: "EUR", description: "Euro", sellRate: "1.501", buyRate: "1.6", sellTransfer: "1.5138", buyTransfer: "1.5916")
    static let usd = Rate(currency: "USD", description: "US Dollar", sellRate: "0.737", buyRate: "0.79", sellTransfer: "0.7426", buyTransfer: "0.7807")
}

extension Currency {
    static let aud = Currency(id: "AUD", description: "Australian Dollar", reverseUsdQuot: false, rates: [Rate.eur, Rate.usd])
}
