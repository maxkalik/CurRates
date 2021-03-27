//
//  SegmentedPickerView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI

struct SegmentedPickerView: View {

    @Binding var generalCurrency: GeneralCurrency

    var body: some View {
        HStack {
            Picker(selection: $generalCurrency, label: Text(""), content: {
                ForEach(GeneralCurrency.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }).pickerStyle(SegmentedPickerStyle())
        }
    }
}
