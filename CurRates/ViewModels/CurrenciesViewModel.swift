//
//  CurrenciesViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import Foundation
import Combine

class CurrenciesViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var list: [CurrencyViewModel] = [CurrencyViewModel]()
    var date: String {
        return getCurrentDate()
    }
    
    private var cancellable: AnyCancellable?
    
    func fetchCurrencies() {
        
        let language = Locale.current.language
        let location = Locale.current.location

        isLoading = true
        cancellable = NetworkService
            .fetchCurrencies(with: [.language: language, .location: location])
            .catch { [self] failureReason -> Just<Currencies> in
                isLoading = false
                isError = true
                return Just(Currencies(data: [], success: false))
            }
            .sink(receiveCompletion: { _ in }, receiveValue: { [self] currencies in
                isLoading = false
                list = currencies.data.map(CurrencyViewModel.init)
            })
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
