//
//  CurrencyDetailsView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI


struct CurrencyDetailsView: View {
    
    @ObservedObject var currency: CurrencyViewModel
    @State private var isShowOnWidget: Bool = false
    
    init(currency: CurrencyViewModel) {
        self.currency = currency
    }
    
    var body: some View {
        return ScrollView {
            Text(currency.id)
                .font(.system(size: 54))
                .fontWeight(.bold)
            Text(currency.description)
                .font(.system(size: 24))
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            Divider()
            Toggle(isOn: $isShowOnWidget) {
                Text("Show on Widget")
            }.onChange(of: isShowOnWidget) { isOn in
                currency.showAtWidget(currencyId: currency.id)
            }.onAppear {
                isShowOnWidget = currency.isOnWidgetSelected
            }.disabled(isShowOnWidget)
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
            ForEach(currency.details) { detail in
                Divider()
                VStack {
                    ValueHeadingView(leftTitle: detail.unitTitle, rightTitle: detail.rateTypeTitle)
                    ValueLineView(title: "Sell", value: detail.sell)
                    ValueLineView(title: "Buy", value: detail.buy)
                }.frame(width: 260).padding(.top, 10)
            }
        }
        .padding(.top, 1)
        .padding(.bottom, 30)
    }
}

struct CurrencyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailsView(currency: CurrencyViewModel(currency: Currency.aud))
    }
}
