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
            operatorPressed(op: Operator(label))
        }
    }
    func setDisplayValue(number: Double){
        //Don't display decimal if number is an integer
        if number == floor(number){
            displayValue = "\(Int(number))"
        }
        //Display decimal
        else{
            let decimalPlaces = 10
            displayValue = "\(round(number * pow(10,decimalPlaces)) / pow(10,decimalPlaces))"
        }
    }
    func reset(){
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equalPress = false
        decimalPlace = 0
    }
    // Returns true if division by 0 could happen
    func checkForDivision() -> Bool {
        if currentOp!.isDivision && (currentNumber == nil && previousNumber == 0 || currentNumber == 0){
            displayValue = "Error"
            reset()
            return true
        }
        return false
    }
    func equalsClicked(){
        // Check if we have an operation to perform
        if currentOp != nil {
            //Reset the decimal place for current number
            decimalPlace = 0
            //Guard for division by 0
            if checkForDivision(){return}
            //Check if we have at least one operator
            if currentNumber != nil || previousNumber != nil {
                // Compute the total
                let total = currentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)
                // Update the first operand
                if currentNumber == nil {
                    currentNumber = previousNumber
                }
                // Update the second operand
                previousNumber = total
                
                //Set the equaled flag
                equalPress = true
                
                //Update UI
                setDisplayValue(number: total)
            }
        }
    }

    func decimalClicked(){
        // If equals was pressed, reset the current numbers
        if equalPress{
            currentNumber = nil
            previousNumber = nil
            equalPress = false
        }
        // If a "." was typed first, set the current number
        if currentNumber == nil {
            currentNumber = 0
        }
        // Set the decimal place
        decimalPlace = 1
        // Update the UI
        setDisplayValue(number: currentNumber!)
        displayValue.append(".")
    }
    func numberPressed(value: Double){
        // If equals was pressed clear the current numbers
        if equalPress{
            currentNumber = nil
            previousNumber = nil
            equalPress = false
        }
        //If there is no current number, set it to the value
        if currentNumber == nil {
            if checkForDivision(){return}
             currentNumber = value / pow(10, decimalPlace)
        }
        //otherwise, add the value to the current number
        else{
            //if no decimal was typed, add the value as the last digit of the number
            if decimalPlace == 0 {
                //force unwrap because we checked that its not nil
                currentNumber = currentNumber! * 10 + value
                //Otherwise,add the value as the last decimal of the numbers
            }
            else{
                currentNumber = currentNumber! + value / pow(10,decimalPlace)
                decimalPlace += 1
                
            }
        }
        //Update the UI
        setDisplayValue(number: currentNumber!)
    }
    func operatorPressed(op: Operator){
        //Reset the decimal
        decimalPlace = 0
        //if equal was pressed, reset the current number
        if equalPress{
            currentNumber = nil
            equalPress = false
        }
        // If we have two operand, compute them
        if currentNumber != nil && previousNumber != nil{
            let total = currentOp!.op(previousNumber!,currentNumber!)
            previousNumber = total
            currentNumber = nil
            
            //Update the UI
            setDisplayValue(number: total)
        }
            //if only one number has been given, move it to previous operand
        else if previousNumber == nil {
            previousNumber = currentNumber
            currentNumber = nil
        }
        currentOp = op
    }
}
func pow(_ base: Int, _ exp: Int) -> Double{
    return pow(Double(base), Double(exp))
}
