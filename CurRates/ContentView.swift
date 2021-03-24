//
//  ContentView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/24/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        print("init content view")
        NetworkService.shared.fetchCurrencies(with: [.language:.RU, .location:.LV]) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print("ERROR! --", error)
            }
        }
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
