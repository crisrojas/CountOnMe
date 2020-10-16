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
    
    let view: SimpleCalcView!
    
    init(view: SimpleCalcView) {
        self.view = view
    }
    
    var elements: [String] {
        return view.textView.text.split(separator: " ").map { "\($0)" }
    }
    
    var expressionIsCorrect: Bool {
        return elements.last != Operands.plus.symbol
            && elements.last != Operands.less.symbol
            && elements.last != Operands.multiply.symbol
            && elements.last != Operands.divide.symbol
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
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
    
    func tapEqual(sender: UIButton) {
        guard expressionIsCorrect else {
            view.presentErrorAlert(with: Error.incorrectExpression.title, and: Error.incorrectExpression.message)
            return
        }
        
        guard expressionHaveEnoughElement else {
            view.presentErrorAlert(with: Error.notEnoughElements.title, and: Error.notEnoughElements.message)
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            
            let result: Float
            
            switch operand {
            case Operands.plus.symbol:
                result = left + right
            case Operands.less.symbol:
                result = left - right
            case Operands.multiply.symbol:
                result = left * right
            case Operands.divide.symbol:
                result = left / right
            default: fatalError(Error.unknownOperator.message)
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        view.textView.text.append(" = \(operationsToReduce.first!)")
    }
    
    func executeCalc(with operand: Operands) {
        if expressionIsCorrect {
            view.textView.text.append(" \(operand.symbol) ")
        } else {
            view.presentErrorAlert(with: Error.moreThanOneOperator.title, and: Error.moreThanOneOperator.message)
        }
    }
}
