//
//  CurrenciesViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import Foundation

class CurrenciesViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var list: [CurrencyViewModel] = [CurrencyViewModel]()
    var date: String {
        return getCurrentDate()
    }
    
    func load() {
        isLoading = true
        NetworkService.shared.fetchCurrencies(with: [.language:.EN, .location:.LV]) { result in
            switch result {
            case .success(let currencies):
                DispatchQueue.main.async {
                    self.list = currencies.data.map(CurrencyViewModel.init)
                    self.isLoading = false
                }
            case .failure(let error):
                print("ERROR! --", error)
                self.isLoading = false
            }
        }
    }
    
    func getCurrentDate() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: today)
    }
}