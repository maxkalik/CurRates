//
//  CurrencyCellView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI

struct CurrencyCellView: View {
    @ObservedObject var currency: CurrencyViewModel
    
    init(currency: CurrencyViewModel, unit: Currency.Unit) {
        self.currency = currency
        self.currency.updateCurrencyUnit(unit)
    }
    
    var body: some View {
        return HStack {
            VStack(alignment: .leading) { currencyTitle }
                .padding(titleEdge())
            Spacer()
            MiniRatesView(buy: currency.buy, sell: currency.sell)
        }
    }
    
    @ViewBuilder
    private var currencyTitle: some View {
        Text(currency.id)
            .font(.system(size: 22))
            .fontWeight(.bold)
        Text(currency.description)
            .font(.system(size: 18))
            .foregroundColor(.gray)
    }
    
    private func titleEdge() -> EdgeInsets {
        return EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
    }
}

struct CurrencyCellView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCellView(currency: CurrencyViewModel(currency: Currency.aud), unit: .USD)
    }
}
