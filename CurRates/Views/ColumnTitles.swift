//
//  ColumnTitle.swift
//  CurRates
//
//  Created by Maksim Kalik on 5/1/21.
//

import SwiftUI

struct ColumnTitles: View {
    let title: LocalizedStringKey
    let subTitles: [String]
    
    init(title: LocalizedStringKey, _ subTitles: [String]) {
        self.title = title
        self.subTitles = subTitles
    }
    
    var body: some View {
        return VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, maxHeight: 38, alignment: .leading)
            
                ForEach(subTitles, id: \.self) { subTitle in
                    Text(LocalizedStringKey(subTitle))
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, maxHeight: 38, alignment: .leading)
                
                }
            }
    }
}

struct ColumnTitle_Previews: PreviewProvider {
    static var previews: some View {
        ColumnTitles(title: LocalizedStringKey("USD"), ["Transfer", "Rate"])
    }
}
