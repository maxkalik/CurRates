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
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .frame(maxHeight: 38, alignment: .trailing)
            }
        }
    }
}

struct Column_Previews: PreviewProvider {
    static var previews: some View {
        Column(title: LocalizedStringKey("Sell"), ["123.456", "123.654"])
    }
}
