//
//  ContentView.swift
//  CalculatorApp
//
//  Created by Linda Imeri on 25.10.22.
//

import SwiftUI
//globl constants
//Custom colors
let darkerGray = Color(CGColor(gray: 0.1, alpha: 1))
let darkGray = Color(CGColor(gray: 0.3, alpha: 1))

struct CalculatorHome: View {
    @EnvironmentObject var calculator: Calculator
    var body: some View {
        GeometryReader {geometry in
            VStack(alignment: .trailing, spacing: 0){
                Spacer()
                //Display the current value
                Text(calculator.displayValue)
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    .lineLimit(1)
                    .padding(.trailing,20)
                
                //Display the rows of buttons, each with specified labels
                VStack(spacing: 10){
                    CalculatorRow(labels: ["CE","","",String("\u{00f7}")], colors: [darkGray,darkGray,darkGray,.orange])
                    CalculatorRow(labels: ["7","8","9",String("\u{00f7}")])
                    CalculatorRow(labels: ["4","5","6","-"])
                    CalculatorRow(labels: ["1","2","3","+"])
                    CalculatorRow(labels: ["0",".","","="])
                }.padding()
                //Get the size of screen and set the height 70% of that height
                    .frame(height: geometry.size.height * 0.7 )
            }
        }
        .background(darkerGray)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CalculatorHome_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorHome()
            .environmentObject(Calculator())
    }
}
