//
//  Operands.swift
//  CountOnMe
//
//  Created by Cristian Rojas on 16/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum Operands {
    case plus
    case less
    case multiply
    case divide
    
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
        }
    }
}
