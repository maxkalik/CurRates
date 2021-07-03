//
//  CurrencyDetailsView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI


struct CurrencyDetailsView: View {
    
    @StateObject var currency: CurrencyViewModel
    @State private var isShowOnWidget: Bool = false
    
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
            Toggle(isOn: $isShowOnWidget.onChange(toggleChanged)) {
                Text(LocalizedStringKey("SwitchTitleShowOnWidget"))
            }
                .onAppear { isShowOnWidget = currency.isOnWidgetSelected }
                .disabled(isShowOnWidget)
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
            ForEach(currency.details) { details in
                Divider()
                HStack (alignment: .firstTextBaseline) {
                    ColumnTitles(title: LocalizedStringKey(details.title.rawValue), ["Transfer", "Rate"])
                    Column(title: LocalizedStringKey("Sell"), [details.transfer.sell, details.rate.sell])
                        .padding(.trailing, 8)
                    Column(title: LocalizedStringKey("Buy"), [details.transfer.buy, details.rate.buy])
                }
                .padding(.top, 10)
                .padding(.horizontal, 30)
            }
            
        }
        .padding(.top, 1)
        .padding(.bottom, 30)
    }
    
    func toggleChanged(_ value: Bool) {
        currency.showAtWidget(currencyId: currency.id)
    }
}


struct CurrencyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailsView(currency: CurrencyViewModel(currency: Currency.gbr))
    }
}
