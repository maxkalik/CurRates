//
//  CurrencyView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import SwiftUI

struct CurrencyListView: View {
    
    let currencies: [CurrencyViewModel]
    @Binding var unit: Currency.Unit
    
    var body: some View {
        List(currencies) { currency in
            ZStack {
                CurrencyCellView(currency: currency, unit: unit)
                NavigationLink(destination: CurrencyDetailsView(currency: currency)) {
                    EmptyView()
                }.hidden()
            }
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView(currencies: [CurrencyViewModel(currency: Currency.aud)], unit: .constant(.USD))
    }
}
