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
                    ColumnTitles(title: LocalizedStringKey(details.title.rawValue), ["Transfer", "Rate"])
                    Column(title: LocalizedStringKey("Sell"), [details.transfer.sell, details.transfer.buy])
                        .padding(.trailing, 8)
                    Column(title: LocalizedStringKey("Buy"), [details.rate.sell, details.rate.buy])
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
    
    let title: LocalizedStringKey
    let subTitles: [String]
    
    init(title: LocalizedStringKey, _ subTitles: [String]) {
        self.title = title
        self.subTitles = subTitles
    }
    
    var body: some View {
        return VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                    .frame(maxHeight: 38, alignment: .leading)
            
                ForEach(subTitles, id: \.self) { subTitle in
                    Text(LocalizedStringKey(subTitle))
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, maxHeight: 38, alignment: .leading)
                
                }
            }.frame(maxWidth: .infinity)
    }
}

struct Column: View {
    
    let title: LocalizedStringKey
    let values: [String]
    
    init(title: LocalizedStringKey, _ values: [String]) {
        self.title = title
        self.values = values
    }
    
    var body: some View {
        return VStack(alignment: .trailing) {
            Text(title)
                .padding(.bottom, 8)
                .frame(maxHeight: 38, alignment: .trailing)
            
            ForEach(values, id: \.self) { value in
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .frame(maxHeight: 38, alignment: .trailing)
            }
        }
    }
}


struct CurrencyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailsView(currency: CurrencyViewModel(currency: Currency.aud))
    }
}
