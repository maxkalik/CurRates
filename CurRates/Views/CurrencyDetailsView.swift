//
//  CurrencyDetailsView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI

struct CurrencyDetailsView: View {
    
    var currency: CurrencyViewModel
    
    init(currency: CurrencyViewModel) {
        self.currency = currency
    }
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct CurrencyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailsView(currency: CurrencyViewModel(currency: Currency.aud))
    }
}
