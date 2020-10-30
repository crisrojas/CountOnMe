//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calculator = Calculator()
    
    override func viewDidLoad() { super.viewDidLoad() }
    
    // View actions
    @IBAction func tappedResetButton(_ sender: UIButton) {
        textView.text = "0"
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
       tapNumber(sender: sender)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        executeCalc(with: Operands.addition)
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        executeCalc(with: Operands.substraction)
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        executeCalc(with: Operands.multiplication)
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        executeCalc(with: Operands.division)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        tapEqual()
    }
    
}

private extension CalcViewController {
    
    var elements: [String] {
           return textView.text.split(separator: " ").map { "\($0)" }
       }
       
       var expressionHaveResult: Bool {
           return textView.text.firstIndex(of: "=") != nil
       }
       
    
    func tapNumber(sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        /// Clears the textView if its content have a result (tappedEqualButton) or has been cleaned with the "AC" button (textView.text == 0)
        if textView.text == "0" || expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    func tapEqual() {
        let result = calculator.compute(elements: elements)
        
        switch result {
        case .failure(let error):
            presentErrorAlert(with: error.title, and: error.message)
        case .success(let success):
            textView.text.append(" = \(success)")
        }
    }
    
    func executeCalc(with operand: Operands) {
        if calculator.expressionIsCorrect(elements: elements) {
            textView.text.append(" \(operand.symbol) ")
        } else {
            presentErrorAlert(with: CalcError.moreThanOneOperator.title, and: CalcError.moreThanOneOperator.message)
        }
    }
}

