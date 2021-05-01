//
//  Column.swift
//  CurRates
//
//  Created by Maksim Kalik on 5/1/21.
//

import SwiftUI

struct Column: View {
    
    let title: LocalizedStringKey
    let values: [String]
    
    init(title: LocalizedStringKey, _ values: [String]) {
        self.title = title
        self.values = values
    }
    
    var body: some View {
        return VStack(alignment: .trailing) {
            Text(title)
                .padding(.bottom, 8)
                .frame(maxHeight: 38, alignment: .trailing)
            
            ForEach(values, id: \.self) { value in
                if value.isEmpty {
                    Text("•••")
                        .foregroundColor(Color.gray)
                        .modifier(RowTextStyle())
                } else {
                    Text(value)
                        .fontWeight(.bold)
                        .modifier(RowTextStyle())
                }
            }
        }
    }
}

struct RowTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding(.bottom, 8)
            .frame(maxHeight: 38, alignment: .trailing)
    }
}

struct Column_Previews: PreviewProvider {
    static var previews: some View {
        Column(title: LocalizedStringKey("Sell"), ["123.456", "123.654"])
    }
}
