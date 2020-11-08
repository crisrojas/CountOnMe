//
//  Calculator.swift
//  CountOnMe
//
//  Created by Cristian Rojas on 16/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

class Calculator {
    
    func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != Operands.addition.symbol
            && elements.last != Operands.substraction.symbol
            && elements.last != Operands.multiplication.symbol
            && elements.last != Operands.division.symbol
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
        
        /// Iterate over operations while an operand still there
        while operationsToReduce.count > 1 {
            var result: Float
            
            /// Checks if array contains a priority operand (multiplication or division) and returns the index if true
            let firstIndex = operationsToReduce.firstIndex { operand -> Bool in
                operand == Operands.multiplication.symbol || operand == Operands.division.symbol
            }
        
            if let index = firstIndex {
                
                let left = Float(operationsToReduce[index - 1]) ?? 1
                let operand = operationsToReduce[index]
                let right = Float(operationsToReduce[index + 1]) ?? 1
                
                switch operand {
                case Operands.multiplication.symbol:
                    result = left * right
                case Operands.division.symbol:
                    result = left / right
                default:
                    return .failure(CalcError.unknownOperator)
                }
                
                let array = [index + 1, index, index - 1]
                for i in array {
                    operationsToReduce.remove(at: i)
                }
                
                operationsToReduce.insert(result.isInt ? "\(Int(result))" : "\(result)", at: index - 1)
                
            } else {
                
                let left = Float(operationsToReduce[0]) ?? 0
                let operand = operationsToReduce[1]
                let right = Float(operationsToReduce[2]) ?? 0
                
                switch operand {
                case Operands.addition.symbol:
                    result = left + right
                case Operands.substraction.symbol:
                    result = left - right
                default:
                    return .failure(CalcError.unknownOperator)
                }
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert(result.isInt ? "\(Int(result))" : "\(result)", at: 0)
            }
        }
        return .success(operationsToReduce.first ?? "")
    }
}
