//
//  CurrenciesViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import Foundation

class CurrenciesViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var list: [CurrencyViewModel] = [CurrencyViewModel]()
    var date: String {
        return getCurrentDate()
    }
    
    func load() {
        isLoading = true
        NetworkService.shared
            .fetchCurrencies(with: [.language: .EN, .location: .LV]) { [self] result in
            switch result {
            case .success(let currencies):
                DispatchQueue.main.async {
                    list = currencies.data.map(CurrencyViewModel.init)
                    isLoading = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                isError = true
                isLoading = false
            }
        }
    }
    
    func getCurrentDate() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: today)
    }
    
    func getCurrencies(_ searchText: String) -> [CurrencyViewModel] {
        return searchText.isEmpty ? list : list.filter {
            $0.id.localizedStandardContains(searchText) || $0.description.localizedStandardContains(searchText)
        }
    }
}
