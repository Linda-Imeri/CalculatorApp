//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Linda Imeri on 25.10.22.
//

import SwiftUI

struct CalculatorButton: View {
    @EnvironmentObject var calculator: Calculator
    var label: String
    var color: Color
    
    var body: some View {
        Button {
            //Inform model of button press
            calculator.buttonPressed(label: label)
            
        } label: {
            ZStack{
                Circle().fill(color)
                Text(label).font(.title)
            }
        }
        //White color for button text
        .accentColor(.white)

    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(label: "1", color:.gray)
            .previewLayout(.fixed(width: 100, height: 100))
            .environmentObject(Calculator())
    }
}
