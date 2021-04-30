//
//  ValueHeadingView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import SwiftUI

struct ValueHeadingView: View {
    private(set) var leftTitle: String
    private(set) var rightTitle: String
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(leftTitle))
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Text(LocalizedStringKey(rightTitle))
            
        }
    }
}
