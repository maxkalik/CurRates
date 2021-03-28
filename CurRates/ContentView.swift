//
//  ContentView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var currenciesViewModel = CurrenciesViewModel()
    @ObservedObject private var searchBar: SearchBar = SearchBar()
    @State var unit: CurrencyUnit = .EUR
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22, weight: .bold),.foregroundColor: UIColor.systemGray4]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 34, weight: .bold), .foregroundColor: UIColor.systemGray4]
        currenciesViewModel.load()
    }

    var body: some View {

        let currenciesList = searchBar.text.isEmpty ? currenciesViewModel.list : currenciesViewModel.list.filter {
            $0.id.localizedStandardContains(searchBar.text)
        }

        if currenciesViewModel.isLoading {
            ProgressView()
        } else {
            NavigationView {
                CurrencyListView(currencies: currenciesList, unit: $unit)
                    .navigationBarTitle(Text("Currencies"), displayMode: .large)
                    .navigationBarItems(leading:
                                            Text(currenciesViewModel.date)
                                            .fontWeight(.bold)
                                            .font(.system(size: 22))
                                            .padding(.bottom, 4),
                                        trailing: SegmentedPickerView(unit: $unit))
                    .add(self.searchBar)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
