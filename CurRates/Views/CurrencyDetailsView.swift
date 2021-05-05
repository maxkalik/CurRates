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
            currencyTitle
            Divider()
            toggle()
            currencyDetails()
        }
            .padding(.top, 1)
            .padding(.bottom, 30)
    }
    
    private func toggle() -> some View {
        return Toggle(isOn: $isShowOnWidget.onChange(toggleChanged)) {
            Text(LocalizedStringKey("SwitchTitleShowOnWidget"))
        }
            .onAppear { isShowOnWidget = currency.isOnWidgetSelected }
            .disabled(isShowOnWidget)
            .padding(.horizontal, 30)
            .padding(.vertical, 16)
    }
    
    private func currencyDetails() -> some View {
        return ForEach(currency.details) { details in
            Divider()
            HStack (alignment: .firstTextBaseline) {
                tableBody(details: details)
            }
                .padding(.top, 10)
                .padding(.horizontal, 30)
        }
    }
    
    @ViewBuilder
    private var currencyTitle: some View {
        Text(currency.id)
            .font(.system(size: 54))
            .fontWeight(.bold)
        Text(currency.description)
            .font(.system(size: 24))
            .foregroundColor(.gray)
            .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private func tableBody(details: CurrencyDetailsModelView) -> some View {
        ColumnTitles(title: LocalizedStringKey(details.title.rawValue), ["Transfer", "Rate"])
        Column(title: LocalizedStringKey("Sell"), [details.transfer.sell, details.transfer.buy])
            .padding(.trailing, 8)
        Column(title: LocalizedStringKey("Buy"), [details.rate.sell, details.rate.buy])
    }
    
    private func toggleChanged(_ value: Bool) {
        currency.showAtWidget(currencyId: currency.id)
    }
}


struct CurrencyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailsView(currency: CurrencyViewModel(currency: Currency.aud))
    }
}
