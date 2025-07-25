//
//  CalcController.swift
//  Calculator
//
//  Created by Marcin Wawer on 19-06-2025.
//

import UIKit

class CalcController: UIViewController {
    
    @IBOutlet weak var expressionLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    
    private var inputBuffer: String = ""
    private var firstNumber: Double?
    private var currentOperator: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }

    @IBAction func digitPressed(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        inputBuffer += digit
        expressionLabel.text = (expressionLabel.text ?? "") + digit
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        guard let mathOp = sender.currentTitle else { return }
        
        if mathOp == "=" {
            guard let first = firstNumber,
                  let second = Double(inputBuffer),
                  let currentOp = currentOperator,
                  let result = performOperation(currentOp, first, second)
            else { return }
            
            resultsLabel.text = "\(result)"
            expressionLabel.text = ""
            firstNumber = nil
            currentOperator = nil
            inputBuffer = ""
        } else {
            guard let currentValue = Double(inputBuffer) else { return }
            
            if let first = firstNumber, let currentOp = currentOperator {
                guard let result = performOperation(currentOp, first, currentValue) else { return }
                firstNumber = result
            } else {
                firstNumber = currentValue
            }
            
            currentOperator = mathOp
            expressionLabel.text = (expressionLabel.text ?? "") + " \(mathOp) "
            inputBuffer = ""
        }
    }
    
    @IBAction func specialPressed(_ sender: UIButton) {
        guard let symbol = sender.currentTitle else { return }
        
        switch symbol {
        case "AC":
            clearAll()
        case "+/-":
            if let text = expressionLabel.text, let value = Double(text) {
                expressionLabel.text = "\(value * -1)"
                inputBuffer = String(value * -1)
            }
        case "%":
            if let text = expressionLabel.text, let value = Double(text) {
                resultsLabel.text = "\(value / 100)"
                expressionLabel.text = ""
                inputBuffer = ""
            }
        default:
            break
        }
    }
    
    
    @IBAction func decimalPressed(_ sender: UIButton) {
        if inputBuffer == "" {
            inputBuffer += "0."
            expressionLabel.text = (expressionLabel.text ?? "") + "0."
        } else {
            inputBuffer += "."
            expressionLabel.text = (expressionLabel.text ?? "") + "."
        }
    }
}

extension CalcController {
    
    private func performOperation(_ op: String, _ first: Double, _ second: Double) -> Double? {
        switch op {
        case "+":
            return first + second
        case "-":
            return first - second
        case "×":
            return first * second
        case "÷":
            guard second != 0 else {
                resultsLabel.text = "Undefined"
                return nil
            }
            
            return first / second
        default:
            return nil
        }
    }
    
    private func clearAll() {
        inputBuffer = ""
        resultsLabel.text = ""
        expressionLabel.text = ""
        firstNumber = nil
        currentOperator = nil
    }
}
