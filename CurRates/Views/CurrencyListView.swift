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
                NavigationLink(destination: CurrencyDetailsView(currency: currency)) {
                    EmptyView()
                }.hidden()
            }
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView(currencies: [CurrencyViewModel(currency: Currency.aud)], generalCurrency: .constant(.USD))
    }
}
