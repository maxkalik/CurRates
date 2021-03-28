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
        ScrollView {
            Text(currency.id)
                .font(.system(size: 54))
                .fontWeight(.bold)
            Text(currency.description)
                .font(.system(size: 24))
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            ForEach(currency.details) { detail in
                Divider()
                VStack {
                    ValueHeadingView(leftTitle: detail.unitTitle, rightTitle: detail.rateTypeTitle)
                    ValueLineView(title: "SELL", value: detail.sell)
                    ValueLineView(title: "BUY", value: detail.buy)
                }.frame(width: 260).padding(.top, 10)
            }
            Divider()
                .padding(.bottom, 20)
            Button(action: {
                currency.showAtWidget(currencyId: currency.id)
            }, label: {
                Text("Show at Widget")
            })
            .padding(.horizontal, 30)
            .padding(.vertical, 16)
            .foregroundColor(Color(.systemBackground))
            .background(Color(.systemBlue))
            .clipShape(Capsule())
        }
        .padding(.top, 1)
        .padding(.bottom, 30)
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
