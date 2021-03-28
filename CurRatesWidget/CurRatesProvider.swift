//
//  CurRatesProvider.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import SwiftUI

public class CureRatesProvider {
    
    @AppStorage("currency", store: UserDefaults(suiteName: "group.maxkalik.com.CurRates.Currencies")) var currencyData = Data()
    
    static func getCurrency(by id: String, completion: @escaping (CurrencyViewModel) -> Void) {
        print("getCurrency id: ", id)
        NetworkService.shared.fetchCurrencies(with: [.language:.EN, .location:.LV]) { result in
            switch result {
            case .success(let currencies):
                guard let currency = currencies.data.filter({ $0.id == id }).first else { return }
                completion(CurrencyViewModel(currency: currency))
            case .failure(let error):
                print("ERROR! --", error)
            }
        }
    }
}
