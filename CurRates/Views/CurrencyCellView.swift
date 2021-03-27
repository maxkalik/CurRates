//
//  CurrencyCellView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI

struct CurrencyCellView: View {
    var currency: CurrencyViewModel
    
    init(currency: CurrencyViewModel, generalCurrency: GeneralCurrency) {
        self.currency = currency
        self.currency.updateGeneralCurrency(generalCurrency)
    }
    
    var body: some View {
        return HStack {
            VStack(alignment: .leading) {
                Text(currency.id)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Text(currency.description)
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            Spacer()
            if !(currency.buy.isEmpty && currency.sell.isEmpty) {
                VStack {
                    RateView(title: "Buy", value: currency.buy)
                        .padding(.bottom, 1)
                    RateView(title: "Sell", value: currency.sell)
                }
            } else {
                Text("—")
                    .padding(.trailing, 8)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CurrencyCellView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dummyRateEur = Rate(currency: "EUR", description: "Euro", sellRate: "1.501", buyRate: "1.6", sellTransfer: "1.5138", buyTransfer: "1.5916")
        let dummyRateUsd = Rate(currency: "USD", description: "US Dollar", sellRate: "0.737", buyRate: "0.79", sellTransfer: "0.7426", buyTransfer: "0.7807")
        let dummyCurrency = Currency(id: "AUD", description: "Australian Dollar", reverseUsdQuot: true, rates: [dummyRateEur, dummyRateUsd])
        
        CurrencyCellView(currency: CurrencyViewModel(currency: dummyCurrency), generalCurrency: .USD)
    }
}

struct RateView: View {
    var title: String
    var value: String
    var body: some View {
        HStack {
            Text(value)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width: 100, alignment: .trailing)
            Text(title).modifier(LabelStyle())
                .frame(width: 35, alignment: .leading)
        }
    }
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(Color(.systemBackground))
            .padding(.horizontal, 5.0)
            .padding(.vertical, 2.0)
            .background(Color(.quaternaryLabel))
            .clipShape(Capsule())
        
    }
}
