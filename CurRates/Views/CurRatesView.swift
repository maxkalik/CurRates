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
    @State private var unit: Currency.Unit = Settings.currency
    
    init() {
        CurRatesViewHelper.shared.navigationBarAppearance()
        currenciesViewModel.fetchCurrencies()
    }

    var body: some View {

        let currenciesList = currenciesViewModel.getCurrencies(searchBar.text)

        if currenciesViewModel.isLoading {
            ProgressView()
        } else if currenciesViewModel.isError {
            Text(LocalizedStringKey("ErrorMessageGeneral"))
            Button(LocalizedStringKey("ButtonTitleTryAgain")) {
                currenciesViewModel.fetchCurrencies()
            }.padding(.top, 10)
        } else {
            navigation(currencies: currenciesList)
        }
    }
    
    private func navigation(currencies: [CurrencyViewModel]) -> some View {
        return NavigationView {
            CurrencyListView(currencies: currencies, unit: $unit)
                .navigationBarTitle(LocalizedStringKey("NavBarTitle"), displayMode: .large)
                .navigationBarItems(
                    leading: leadingBarItem,
                    trailing: SegmentedPickerView(unit: $unit))
                .add(self.searchBar)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var leadingBarItem: some View {
        return Text(currenciesViewModel.date)
            .fontWeight(.bold)
            .font(.system(size: 22))
            .padding(.bottom, 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurRatesView()
            .environment(\.colorScheme, .dark)
    }
}
