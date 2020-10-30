import Foundation

enum Operands {
    case plus
    case less
    case multiply
    case divide
    case equal
    
    var symbol: String {
        switch self {
        case .plus:
            return "+"
        case .less:
            return "-"
        case .multiply:
            return "x"
        case .divide:
            return "÷"
        case .equal:
            return "="
        }
    }
}

var operationsToReduce = ["1", Operands.plus.symbol, "2", Operands.multiply.symbol, "2", "+", "2", Operands.divide.symbol, "2"]
/*
 
 ["1", "+", "2", "*", "2", "+", "2", "÷", "2"]
 ["1", "+", "4", "+", "2", "÷", "2"]
 ["1", "+", "4", "+", "1"]
 ["5", "+", "1"]
 ["6"]
 
 */

operationsToReduce.firstIndex { operand -> Bool in
    operand == Operands.multiply.symbol || operand == Operands.divide.symbol
}

/// Iterate over operations while an operand still here

while operationsToReduce.count > 1 {
    
    var result: Float
    
    let firstIndex = operationsToReduce.firstIndex { operand -> Bool in
        operand == Operands.multiply.symbol || operand == Operands.divide.symbol
    }
    
    if let index = firstIndex {
        
        let left = Float(operationsToReduce[index - 1]) ?? 1
        let operand = operationsToReduce[index]
        let right = Float(operationsToReduce[index + 1]) ?? 1
        
        switch operand {
        case Operands.multiply.symbol:
            result = left * right
        case Operands.divide.symbol:
            result = left / right
        default:
            result = 0
        }
        
        let array = [index + 1, index, index - 1]
        for i in array {
            operationsToReduce.remove(at: i)
        }
        
        operationsToReduce.insert("\(result)", at: index-1)
    } else {
        let left = Float(operationsToReduce[0]) ?? 0
        let operand = operationsToReduce[1]
        let right = Float(operationsToReduce[2]) ?? 0
        
        switch operand {
        case Operands.plus.symbol:
            result = left + right
        case Operands.less.symbol:
            result = left - right
        default:
            result = 0
        }
        
        operationsToReduce = Array(operationsToReduce.dropFirst(3))
        operationsToReduce.insert("\(result)", at: 0)
        
    }
    
}

print(operationsToReduce)
