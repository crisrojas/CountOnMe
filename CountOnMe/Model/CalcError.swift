//
//  Constants.swift
//  CountOnMe
//
//  Created by Cristian Rojas on 16/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

/// Constant error strings used in the app

enum CalcError: Error {
    case incorrectExpression
    case notEnoughElements
    case moreThanOneOperator
    case unknownOperator
    case unknownError
    
    
    var title: String {
        switch self {
        case .incorrectExpression:
            return "Expression incorrecte"
        case .notEnoughElements:
            return "L'expression n'a pas assez d'éléments"
        case .moreThanOneOperator:
            return "Ce n'est pas possible d'ajouter un nouveau operateur"
        case .unknownOperator:
            return "Operateur inconnu"
        case .unknownError:
            return "Error inconnu"
        }
    }
    
    var message: String {
        switch self {
        case .incorrectExpression:
            return "Entrez une expression correcte!"
        case .notEnoughElements:
            return "Démarrez un nouveau calcul!"
        case .moreThanOneOperator:
            return "Un operateur est déja mis!"
        case .unknownOperator:
            return "L'operateur est inconnu!"
        case .unknownError:
            return "Il s'est produit un erreur inconnu"
        }
    }
}
