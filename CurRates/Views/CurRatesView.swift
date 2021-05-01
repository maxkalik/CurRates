//
//  ContentView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import SwiftUI

struct CurRatesView: View {
    
    @ObservedObject private var currenciesViewModel = CurrenciesViewModel()
    @StateObject private var searchBar: SearchBar = SearchBar()
    @State private var unit: Currency.Unit = .EUR
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22, weight: .bold),.foregroundColor: UIColor.systemGray4]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 34, weight: .bold), .foregroundColor: UIColor.systemGray4]
        currenciesViewModel.combineLoad()
    }

    var body: some View {

        let currenciesList = currenciesViewModel.getCurrencies(searchBar.text)

        if currenciesViewModel.isLoading {
            ProgressView()
        } else if currenciesViewModel.isError {
            Text(LocalizedStringKey("ErrorMessageGeneral"))
            Button(LocalizedStringKey("ButtonTitleTryAgain")) {
                currenciesViewModel.combineLoad()
            }.padding(.top, 10)
        } else {
            NavigationView {
                CurrencyListView(currencies: currenciesList, unit: $unit)
                    .navigationBarTitle(Text(LocalizedStringKey("NavBarTitle")), displayMode: .large)
                    .navigationBarItems(
                        leading: Text(currenciesViewModel.date)
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
        CurRatesView()
            .environment(\.colorScheme, .dark)
    }
}
