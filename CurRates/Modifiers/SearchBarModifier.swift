//
//  SearchBarModifier.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/26/21.
//

import SwiftUI

struct SearchBarModifier: ViewModifier {

    let searchBar: SearchBar
    
    func body(content: Content) -> some View {
        content.overlay(
            ViewControllerResolver { vc in
                vc.navigationItem.searchController = self.searchBar.searchController
                vc.navigationItem.hidesSearchBarWhenScrolling = false
            }
            .frame(width: 0, height: 0)
        )
    }
}

extension View {
    func add(_ searchBar: SearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
    }
}
