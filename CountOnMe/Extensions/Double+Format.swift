//
//  Float+isInt.swift
//  CountOnMe
//
//  Created by Cristian Rojas on 30/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension Double {
    var format: String {
        let intMax = Double(Int.max)
        if self.truncatingRemainder(dividingBy: 1) == 0 && self < intMax {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }
}
