//
//  RateItemView.swift
//  CurRates
//
//  Created by Maksim Kalik on 4/29/21.
//

import SwiftUI

struct RateItemView: View {
    var title: String
    var value: String
    var reversed: Bool
    
    var body: some View {
        HStack(alignment: .bottom) {
            if reversed {
                Text(title).modifier(LabelStyle())
                    .frame(width: 45, alignment: .trailing)
            }
            Text(value)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width: 100, alignment: .trailing)
            if !reversed {
                Text(title).modifier(LabelStyle())
                    .frame(width: 45, alignment: .leading)
            }
        }
    }
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(Color(.white))
            .padding(.horizontal, 8.0)
            .padding(.vertical, 4.0)
            .background(Color(.quaternaryLabel))
            .clipShape(Capsule())
        
    }
}
