//
//  ValueHeadingView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/28/21.
//

import SwiftUI

struct ValueHeadingView: View {
    var leftTitle: String
    var rightTitle: String
    
    var body: some View {
        HStack {
            Text(leftTitle)
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Text(rightTitle)
            
        }
    }
}
