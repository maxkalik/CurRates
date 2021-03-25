//
//  CurrencyView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import SwiftUI

struct CurrencyListView: View {
    
    let currencies: [CurrencyViewModel]
    
    var body: some View {
        List(self.currencies, id: \.id) { currency in
            CurrencyCellView(currency: currency)
        }
    }
}

struct CurrencyCellView: View {
    let currency: CurrencyViewModel
    
    var body: some View {
        return HStack {
            VStack(alignment: .leading) {
                Text(currency.id)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text(currency.description)
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack {
                Text(currency.buy)
                    .font(.system(size: 22))
                    .foregroundColor(.green)
                Text(currency.sell)
                    .font(.system(size: 22))
                    .foregroundColor(.red)
            }
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dummyRateEur = Rate(currency: "EUR", description: "Euro", sellRate: "1.501", buyRate: "1.6", sellTransfer: "1.5138", buyTransfer: "1.5916")
        let dummyRateUsd = Rate(currency: "USD", description: "US Dollar", sellRate: "0.737", buyRate: "0.79", sellTransfer: "0.7426", buyTransfer: "0.7807")
        let dummyCurrency = Currency(id: "AUD", description: "Australian Dollar", reverseUsdQuot: true, rates: [dummyRateEur, dummyRateUsd])
        
        CurrencyListView(currencies: [CurrencyViewModel(currency: dummyCurrency)])
    }
}
