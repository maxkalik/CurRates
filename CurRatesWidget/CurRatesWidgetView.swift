//
//  CurRatesWidgetView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import SwiftUI

struct CurRatesWidgetView: View {
    
    private(set) var currency: CurrencyViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text(currency.id)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Text(currency.description)
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 2)
            MiniRatesView(buy: currency.buy, sell: currency.sell, reversed: true)
        }
    }
}

struct CurRatesWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        CurRatesWidgetView(currency: CurrencyViewModel(currency: Currency.aud))
    }
}
