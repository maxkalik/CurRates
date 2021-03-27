//
//  CurrencyView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import SwiftUI

struct CurrencyListView: View {
    
    let currencies: [CurrencyViewModel]
    @Binding var generalCurrency: GeneralCurrency
    
    var body: some View {
        List(currencies) { currency in
            
            ZStack {
                CurrencyCellView(currency: currency, generalCurrency: generalCurrency)
                // NavigationLink(destination: CurrencyDetailsView()) {
                //     EmptyView()
                // }.hidden()
            }
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dummyRateEur = Rate(currency: "EUR", description: "Euro", sellRate: "1.501", buyRate: "1.6", sellTransfer: "1.5138", buyTransfer: "1.5916")
        let dummyRateUsd = Rate(currency: "USD", description: "US Dollar", sellRate: "0.737", buyRate: "0.79", sellTransfer: "0.7426", buyTransfer: "0.7807")
        let dummyCurrency = Currency(id: "AUD", description: "Australian Dollar", reverseUsdQuot: true, rates: [dummyRateEur, dummyRateUsd])
        
        CurrencyListView(currencies: [CurrencyViewModel(currency: dummyCurrency)], generalCurrency: .constant(.USD))
    }
}
