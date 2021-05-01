//
//  SegmentedPickerView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/27/21.
//

import SwiftUI

struct SegmentedPickerView: View {

    @Binding var unit: Currency.Unit

    var body: some View {
        HStack {
            Picker(selection: $unit, label: Text("")) {
                ForEach(Currency.Unit.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}
