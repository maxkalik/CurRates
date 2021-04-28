//
//  MiniRatesView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import SwiftUI

struct MiniRatesView: View {
    private(set) var buy: String
    private(set) var sell: String
    private(set) var reversed: Bool?
    
    init(buy: String, sell: String, reversed: Bool? = nil) {
        self.buy = buy
        self.sell = sell
        self.reversed = reversed
    }
    
    var body: some View {
        if !(buy.isEmpty && sell.isEmpty) {
            VStack {
                RateItemView(title: "Sell", value: sell, reversed: reversed ?? false)
                    .padding(.bottom, 1)
                RateItemView(title: "Buy", value: buy, reversed: reversed ?? false)
            }
        } else {
            Text("—")
                .padding(.trailing, 8)
                .foregroundColor(.gray)
        }
    }
}

struct MiniRatesView_Previews: PreviewProvider {
    static var previews: some View {
        MiniRatesView(buy: "20.35", sell: "22.35")
    }
}
