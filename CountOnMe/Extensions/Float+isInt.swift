//
//  Float+isInt.swift
//  CountOnMe
//
//  Created by Cristian Rojas on 30/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

extension Float {
    var isInt: Bool {
        return self.truncatingRemainder(dividingBy: 1) == 0
    }
}
