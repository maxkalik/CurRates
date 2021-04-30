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
                Text(LocalizedStringKey("SwitchTitleShowOnWidget"))
            }.onChange(of: isShowOnWidget) { isOn in
                currency.showAtWidget(currencyId: currency.id)
            }.onAppear {
                isShowOnWidget = currency.isOnWidgetSelected
            }.disabled(isShowOnWidget)
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
            ForEach(currency.details) { details in
                Divider()
                HStack (alignment: .firstTextBaseline) {
                    ColumnTitles(title: LocalizedStringKey(details.title.rawValue))
                    Column(title: LocalizedStringKey("Sell"), details.transfer.sell, details.transfer.buy)
                        .padding(.trailing, 8)
                    Column(title: LocalizedStringKey("Buy"), details.rate.sell, details.rate.buy)
                }
                .padding(.top, 10)
                .padding(.horizontal, 30)
            }
            
        }
        .padding(.top, 1)
        .padding(.bottom, 30)
    }
}

struct ColumnTitles: View {
    
    var title: LocalizedStringKey
    
    var body: some View {
        return VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                    .frame(maxHeight: 38, alignment: .leading)
                Text(LocalizedStringKey("Transfer"))
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, maxHeight: 38, alignment: .leading)
                Text(LocalizedStringKey("Rate"))
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, maxHeight: 38, alignment: .leading)
            }.frame(maxWidth: .infinity)
    }
}


struct Column: View {
    
    var title: LocalizedStringKey
    var value1: String
    var value2: String
    
    init(title: LocalizedStringKey, _ value1: String, _ value2: String) {
        self.title = title
        self.value1 = value1
        self.value2 = value2
    }
    
    var body: some View {
        return VStack(alignment: .trailing) {
            Text(title)
                .padding(.bottom, 8)
                .frame(maxHeight: 38, alignment: .trailing)
            Text(value1)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .frame(maxHeight: 38, alignment: .trailing)
            Text(value2)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .frame(maxHeight: 38, alignment: .trailing)
        }
    }
}


struct CurrencyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailsView(currency: CurrencyViewModel(currency: Currency.aud))
    }
}
