//
//  PreviewData.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import Foundation

extension Rate {
    static let eur = Rate(currency: .EUR, description: "Euro", sellRate: "0.84", buyRate: "0.88", sellTransfer: "0.841", buyTransfer: "0.875")
    static let usd = Rate(currency: .USD, description: "US Dollar", sellRate: "1.344", buyRate: "1.416", sellTransfer: "1.353", buyTransfer: "1.409")
}

extension Currency {
    static let gbr = Currency(id: "GBR", description: "Pound Sterling", reverseUsdQuot: true, rates: [Rate.eur, Rate.usd])
}
