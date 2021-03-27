//
//  ContentView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import SwiftUI

struct ContentView: View {
    
    var generalCurrencies = ["USD", "EUR"]
    
    @ObservedObject private var currenciesViewModel = CurrenciesViewModel()
    @ObservedObject private var searchBar: SearchBar = SearchBar()
    
    @State var generalCurrency = "USD"
    
    init() {
        currenciesViewModel.load()
    }
    
    // @ViewBuilder
    var body: some View {
        
        
        
        let currenciesList = searchBar.text.isEmpty ? currenciesViewModel.list : currenciesViewModel.list.filter {
            $0.id.localizedStandardContains(searchBar.text)
        }
        
        let isLoading = currenciesViewModel.isLoading
        if isLoading {
            ProgressView()
        } else {

            // GeometryReader { geometry in
            //     NavigationView {
            //         RefreshScrollView(width: geometry.size.width, height: geometry.size.height, handlePullToRefresh: {
            //             print(searchBar.text)
            //             print("updated")
            //         }) {
            //             CurrencyListView(currencies: currenciesList)
            //                 // .navigationTitle("Currencies")
            //         }
            //         .add(self.searchBar)
            //         .navigationBarTitle(Text("SwiftUI Pull To Refresh"), displayMode: .inline)
            //
            //     }
            //     .navigationViewStyle(StackNavigationViewStyle())
            // }
            
            
            NavigationView {
                CurrencyListView(currencies: currenciesList, generalCurrency: $generalCurrency)
                    .navigationBarTitle("20.04.2021")
                    .navigationBarItems(leading:
                                            Text("Currencies")
                                            .fontWeight(.bold)
                                            .font(.system(size: 22)),
                                        trailing:
                                            HStack {
                                                Picker(selection: $generalCurrency, label: Text(""), content: {
                                                    ForEach(generalCurrencies, id: \.self) {
                                                        Text($0)
                                                    }
                                                }).pickerStyle(SegmentedPickerStyle())
                                            }
                                        )
                    .add(self.searchBar)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}


// class GeneralCurrencyModelView: ObservedObject {
//     // @Published var generalCurrencyIndex : String = "USD"
// }


// struct SegmentControl: View {
//
//     var generalCurrencies = ["USD", "EUR"]
//     @State private var generalCurrencyIndex: String = "USD"
//
//     var body: some View {
//         HStack {
//             Picker(selection: $generalCurrencyIndex, label: Text(""), content: {
//                 ForEach(generalCurrencies, id: \.self) {
//                     Text($0)
//                 }
//             }).pickerStyle(SegmentedPickerStyle())
//         }
//     }
// }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
