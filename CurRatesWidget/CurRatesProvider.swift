//
//  CurRatesProvider.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import SwiftUI
import Combine

public class CureRatesProvider {
    
    static var cancellable: AnyCancellable?
    
    static func getCurrency(by id: String, completion: @escaping (CurrencyViewModel) -> Void) {
        
        let language = Locale.current.language
        let location = Locale.current.location
        
        cancellable = NetworkService
            .fetchCurrencies(with: [.language: language, .location: location])
            .catch { failureReason -> Just<Currencies> in
                return Just(Currencies(data: [], success: false))
            }
            .sink(receiveCompletion: { _ in }, receiveValue: { currencies in
                guard let currency = currencies.data.filter({ $0.id == id }).first else { return }
                completion(CurrencyViewModel(currency: currency))
            })
    }
}
