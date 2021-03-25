//
//  ContentView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var currencies = CurrenciesViewModel()
    
    init() {
        currencies.load()
    }
    
    var body: some View {
        let currenciesList = self.currencies.list
        let isLoading = self.currencies.isLoading
        if isLoading {
            ProgressView()
        } else {
            // Text(currenciesList.first?.description ?? "–").padding()
            NavigationView {
                ZStack(alignment: .leading, content: {
                    // Color.black
                    Text("January 5 2020")
                    CurrencyListView(currencies: currenciesList)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
