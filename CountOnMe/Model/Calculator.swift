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
    
    func reset() -> String {
        return "0"
    }
    
    func compute(elements: [String]) -> Result<String, CalcError> {
        guard expressionIsCorrect(elements: elements) else {
            return .failure(CalcError.incorrectExpression)
        }
        
        guard expressionHaveEnoughElement(elements: elements) else {
            return .failure(CalcError.notEnoughElements)
        }
        
        var operationsToReduce = elements
        
        while operationsToReduce.count > 1 {
            var result: Double = 0.0
            
            let firstIndex = operationsToReduce.firstIndex { operand -> Bool in
                operand == Operands.multiplication.symbol || operand == Operands.division.symbol
            }
            
            if let index = firstIndex {
                do {
                    try computePrioritaryOperations(operationsToReduce: &operationsToReduce, index: index, result: &result)
                } catch {
                    if let error = error as? CalcError { return .failure(error) }
                }
                
            } else {
                do {
                    try computeNonPrioritaryOperations(operationsToReduce: &operationsToReduce, result: &result)
                } catch {
                    if let error = error as? CalcError { return .failure(error) }
                }
            }
        }
        
        return .success(operationsToReduce.first ?? "")
    }
}


// MARK: - Private methods
private extension Calculator {
    
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }
    
    func computePrioritaryOperations(operationsToReduce: inout [String], index: Int, result: inout Double) throws {
        guard let left = Double(operationsToReduce[index - 1]) else { throw CalcError.inconvertibleString }
        let operand = operationsToReduce[index]
        guard let right = Double(operationsToReduce[index + 1]) else { throw CalcError.inconvertibleString }
       
        if operand == Operands.multiplication.symbol {
            result = left * right
        } else if operand == Operands.division.symbol {
            result = left / right
        }
        
        let array = [index + 1, index, index - 1]
        for i in array {
            operationsToReduce.remove(at: i)
        }
        
        operationsToReduce.insert(result.format, at: index - 1)
    }
    
    func computeNonPrioritaryOperations(operationsToReduce: inout [String], result: inout Double) throws {
        guard let left = Double(operationsToReduce[0]) else { throw CalcError.inconvertibleString }
        let operand = operationsToReduce[1]
        guard let right = Double(operationsToReduce[2]) else { throw CalcError.inconvertibleString }
        
        if operand == Operands.addition.symbol {
            result = left + right
        } else if operand == Operands.substraction.symbol {
            result = left - right
        }
        
        operationsToReduce = Array(operationsToReduce.dropFirst(3))
        operationsToReduce.insert(result.format, at: 0)
    }
}
   
