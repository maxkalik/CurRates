//
//  ValueLineView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import SwiftUI

struct ValueLineView: View {
    
    private(set) var title: String
    private(set) var value: String
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Spacer()
            if value.isEmpty {
                Text("-")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            } else {
                Text(LocalizedStringKey(value))
                    .font(.title)
                    .fontWeight(.bold)
            }
            
        }.padding(.top, 2)
    }
}
