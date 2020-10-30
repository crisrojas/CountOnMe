//
//  Operands.swift
//  CountOnMe
//
//  Created by Cristian Rojas on 16/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

enum Operands {
    case addition
    case substraction
    case multiplication
    case division
    case compute
    
    var symbol: String {
        switch self {
        case .addition:
            return "+"
        case .substraction:
            return "-"
        case .multiplication:
            return "x"
        case .division:
            return "÷"
        case .compute:
            return "="
        }
    }
}
