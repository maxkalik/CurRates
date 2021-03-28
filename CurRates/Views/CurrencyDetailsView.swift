//
//  CurrencyDetailsView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI


struct CurrencyDetailsView: View {
    
    var currency: CurrencyViewModel
    // @State var generalCurrency: GeneralCurrency
    
    init(currency: CurrencyViewModel) {
        self.currency = currency
    }
    
    var body: some View {
        ScrollView {
            Text(currency.id)
                .font(.system(size: 54))
                .fontWeight(.bold)
            Text(currency.description)
                .font(.system(size: 24))
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            Divider()
            VStack {
                ValueHeadingView(leftTitle: "USD", rightTitle: "Transfer")
                ValueLineView(title: "SELL", value: currency.transferSell)
                ValueLineView(title: "BUY", value: currency.transferBuy)
            }.frame(width: 260).padding(.top, 10)
            Divider()
            VStack {
                ValueHeadingView(leftTitle: "USD", rightTitle: "Rate")
                ValueLineView(title: "SELL", value: currency.rateSell)
                ValueLineView(title: "BUY", value: currency.rateBuy)
            }.frame(width: 260).padding(.top, 10)
        }
            .padding(.top, 1)
            // .navigationBarItems(trailing: SegmentedPickerView(generalCurrency: $generalCurrency))
    }
}

struct ValueHeadingView: View {
    var leftTitle: String
    var rightTitle: String
    
    var body: some View {
        HStack {
            Text(leftTitle)
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Text(rightTitle)
            
        }
    }
}

struct ValueLineView: View {
    
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Spacer()
            if value.isEmpty {
                Text("-")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            } else {
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
            }
            
        }.padding(.top, 2)
    }
}



struct CurrencyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailsView(currency: CurrencyViewModel(currency: Currency.aud))
    }
}
