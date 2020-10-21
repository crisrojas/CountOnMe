//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Cristian Rojas on 04/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class SimpleCalc {
    
    let view: SimpleCalcView
    let calculator: Calculator
    
    init(view: SimpleCalcView, calculator: Calculator = Calculator()) {
        self.view = view
        self.calculator = calculator
    }
    
    var elements: [String] {
        return view.textView.text.split(separator: " ").map { "\($0)" }
    }
    
    var expressionHaveResult: Bool {
        return view.textView.text.firstIndex(of: "=") != nil
    }
    
    func tapNumber(sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        /// Clears the textView if its content have a result (tappedEqualButton)
        if expressionHaveResult {
            view.textView.text = ""
        }
        
        view.textView.text.append(numberText)
    }
    
    /// Abstraire dans une classe pour mieux tester
    func tapEqual() {
        let result = calculator.compute(elements: elements)
        
        switch result {
        case .failure(let error):
            view.presentErrorAlert(with: error.title, and: error.message)
        case .success(let success):
            view.textView.text.append(" = \(success)")
        }
    }
    
    func executeCalc(with operand: Operands) {
        if calculator.expressionIsCorrect(elements: elements) {
            view.textView.text.append(" \(operand.symbol) ")
        } else {
            view.presentErrorAlert(with: CalcError.moreThanOneOperator.title, and: CalcError.moreThanOneOperator.message)
        }
    }
}
