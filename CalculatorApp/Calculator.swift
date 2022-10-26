//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Linda Imeri on 26.10.22.
//

import Foundation

class Calculator: ObservableObject{
    //Used to update the UI
    @Published var displayValue = "8"
    
    //Store the current operator
    var currentOp: Operator?
    //Current number selected
    var currentNumber: Double? = 0
    //Previous number selected
    var previousNumber: Double?
    
    //Flag for equal press
    var equalPress = false
    
    //How many decimal places have been typed
    var decimalPlace = 0
    
    /// Select the appropiate function based on the label of he button pressed
    func buttonPressed(label: String){
        if label == "CE"{
            displayValue = "0"
            reset()
        }
        else if label == "="{
            equalsClicked()
        }
        //Check if the value is number
        else if let value = Double(label){
            numberPressed(value: value)
        }
        else {
            operatorPressed(op: Operator())
        }
    }
    func reset(){
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equalPress = false
        decimalPlace = 0
    }
    func equalsClicked(){
        
    }

    func decimalClicked(){
        
    }
    func numberPressed(value: Double){
        
    }
    func operatorPressed(op: Operator){
        
    }

    
}
