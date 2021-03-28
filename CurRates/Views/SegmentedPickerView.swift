//
//  SegmentedPickerView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI

struct SegmentedPickerView: View {

    @Binding var unit: CurrencyUnit

    var body: some View {
        HStack {
            Picker(selection: $unit, label: Text("")) {
                ForEach(CurrencyUnit.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}
