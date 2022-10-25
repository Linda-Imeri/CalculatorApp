//
//  CalculatorRow.swift
//  CalculatorApp
//
//  Created by Linda Imeri on 25.10.22.
//

import SwiftUI
let columnCount = 4
struct CalculatorRow: View {
    var labels = ["","","",""]
    var colors: [Color] = [.gray,.gray,.gray,.orange]
    var body: some View {
        //Display a calculator button for each column
        HStack(spacing: 10){
        //Select from labels and colors
            ForEach(0..<columnCount){index in
                CalculatorButton(label: labels[index], color: colors[index])
            }
        }
    }
}

struct CalculatorRow_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorRow()
    }
}
