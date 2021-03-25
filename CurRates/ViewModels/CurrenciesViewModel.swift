//
//  CurrenciesViewModel.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/25/21.
//

import Foundation

class CurrenciesViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var list: [CurrencyViewModel] = [CurrencyViewModel]()
    @Published var isLoading: Bool = false
    
    func load() {
        isLoading = true
        NetworkService.shared.fetchCurrencies(with: [.language:.EN, .location:.LV]) { result in
            switch result {
            case .success(let currencies):
                DispatchQueue.main.async {
                    // self.list = currencies.data
                    self.list = currencies.data.map(CurrencyViewModel.init)
                    self.isLoading = false
                }
            case .failure(let error):
                print("ERROR! --", error)
                self.isLoading = false
            }
        }
    }
}
