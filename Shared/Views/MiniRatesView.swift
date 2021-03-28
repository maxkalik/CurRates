//
//  MiniRatesView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import SwiftUI

struct MiniRatesView: View {
    let buy: String
    let sell: String
    let reversed: Bool?
    
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

struct RateItemView: View {
    var title: String
    var value: String
    var reversed: Bool
    
    var body: some View {
        HStack(alignment: .bottom) {
            if reversed {
                Text(title).modifier(LabelStyle())
                    .frame(width: 35, alignment: .leading)
            }
            Text(value)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width: 100, alignment: .trailing)
            if !reversed {
                Text(title).modifier(LabelStyle())
                    .frame(width: 35, alignment: .leading)
            }
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

struct MiniRatesView_Previews: PreviewProvider {
    static var previews: some View {
        MiniRatesView(buy: "20.35", sell: "22.35")
    }
}
