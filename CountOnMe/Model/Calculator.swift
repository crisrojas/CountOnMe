//
//  Calculator.swift
//  CountOnMe
//
//  Created by Cristian Rojas on 16/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != Operands.plus.symbol
            && elements.last != Operands.less.symbol
            && elements.last != Operands.multiply.symbol
            && elements.last != Operands.divide.symbol
    }
    
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }
    
    func compute(elements: [String]) -> Result<String, CalcError> {
        guard expressionIsCorrect(elements: elements) else {
            return .failure(CalcError.incorrectExpression)
        }
        
        guard expressionHaveEnoughElement(elements: elements) else {
            return .failure(CalcError.notEnoughElements)
        }
        
        /// Create local copy of operations
        var operationsToReduce = elements
        
        /// Iterate over operations while an operand still here
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
            default: fatalError(CalcError.unknownOperator.message)
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        return .success(operationsToReduce.first ?? "")
    }
}
