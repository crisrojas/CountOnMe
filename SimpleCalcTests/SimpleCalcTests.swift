//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
    var calculator: Calculator!
    
    override func setUp() {
        calculator = Calculator()
    }
    
    func testGivenLastCharacterIsntAnOperator_WhenCallingExpressionIsCorrect_ThenWeShouldGetTrue() {
        
        XCTAssertFalse(calculator.expressionIsCorrect(elements: ["+"]))
        XCTAssertTrue(calculator.expressionIsCorrect(elements: ["1"]))
    }
    
    func testResetButton() {
        let reset = calculator.reset()
        XCTAssertEqual(reset, "0")
    }
    
    // MARK: - Addition & subscraction
    
    func testGiven1plus1_WhenCallingCompute_ThenWeShouldGet2() {
        let operation = calculator.compute(elements: ["1", Operands.addition.symbol, "1"])
        XCTAssertEqual(operation, .success("2"))
    }
    
    func testGiven2minus1_WhenCallingCompute_ThenWeShouldGet1() {
        let operation = calculator.compute(elements: ["2", Operands.substraction.symbol, "1"])
        XCTAssertEqual(operation, .success("1"))
    }
    
    // MARK: - Multiplcation & Division
    
    func testGiven2times2_WhenCallingCompute_ThenWeShouldGet4() {
        let operation = calculator.compute(elements: ["2", Operands.multiplication.symbol, "2"])
        XCTAssertEqual(operation, .success("4"))
    }
    
    func testGiven10divided5_WhenCallingCompute_ThenWeShouldGet2() {
        let operation = calculator.compute(elements: ["10", Operands.division.symbol, "5"])
        XCTAssertEqual(operation, .success("2"))
    }
    
    func testGiven5divided2_WhenCallingCompute_ThenWeShouldGet2dot5() {
        let operation = calculator.compute(elements: ["5", Operands.division.symbol, "2"])
        XCTAssertEqual(operation, .success("2.5"))
    }

    func testGivenNumberIsDividedByZero_WhenCallingCompute_ThenWeShouldGetInfinite() {
        let operation = calculator.compute(elements: ["1", Operands.division.symbol, "0"])
        XCTAssertEqual(operation, .success("inf"))
    }
    
    func testGivenZeroIsDividedByNumber_WhenCallingCompute_ThenWeShouldGetZero() {
        let operation = calculator.compute(elements: ["0", Operands.division.symbol, "2"])
        XCTAssertEqual(operation, .success("0"))
    }
    
    func testGivenZeroIsMultipliedByNumber_WhenCallingCompute_ThenWeShouldGetZero() {
        let operation = calculator.compute(elements: ["0", Operands.multiplication.symbol, "2"])
        XCTAssertEqual(operation, .success("0"))
    }
    
    func testGivenZeroIsDividedByZero_WhenCallingCompute_ThenWeShouldGetNotANumber() {
        let operation = calculator.compute(elements: ["0", Operands.division.symbol, "0"])
        XCTAssertEqual(operation, .success("-nan"))
    }
    
    // MARK: - Prioritary order
    func testGiven1plus1times2_WhenCallingCompute_ThenWeShouldGetThree() {
        let operation = calculator.compute(elements: ["1", Operands.addition.symbol, "1", Operands.multiplication.symbol, "2"])
        XCTAssertEqual(operation, .success("3"))
    }
    
    // MARK: - Multiplication with Big numbers
    func testGiven1e48Times1e48_WhenCallingCompute_ThenWeShouldGet1e96() {
        let double: Double = pow(10, 48)
        let bigNumber = "\(double)"
        let operation = calculator.compute(elements: [bigNumber, Operands.multiplication.symbol, bigNumber])
        XCTAssertEqual(operation, .success("1e+96"))
    }
    
    // MARK: - Errors
    func testGivenExpressionIsIncorrect_WhenCallingCompute_ThenWeShouldGetAFailure() {
        let operation = calculator.compute(elements: ["1", "+"])
        switch operation {
        case .success:
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, CalcError.incorrectExpression)
            XCTAssertEqual(error.title, "Expression incorrecte")
            XCTAssertEqual(error.message, "Entrez une expression correcte!")
        }
    }
    
    func testGivenExpressionHasntEnoughElements_WhenCallingCompute_ThenWeShouldGetAFailure() {
        
        let operation = calculator.compute(elements: ["1"])
        XCTAssertEqual(operation, .failure(CalcError.notEnoughElements))
        
        switch operation {
        case .success:
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, CalcError.notEnoughElements)
            XCTAssertEqual(error.title, "L'expression n'a pas assez d'éléments")
            XCTAssertEqual(error.message, "Démarrez un nouveau calcul!")
        }
    }
    
    func testGivenElementIsInconvertible_WhenCallingComputeWithPriority_ThenShouldGetCalcErrorInconvertibleString() {
        var operation = calculator.compute(elements: ["a", Operands.multiplication.symbol, "2"])
        switch operation {
        case .success:
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error.title, "Impossible de convetir")
            XCTAssertEqual(error.message, "Il n'est pas possible de convertir le string en float")
        }
        
        operation = calculator.compute(elements: ["1", Operands.multiplication.symbol, "a"])
        XCTAssertEqual(operation, .failure(CalcError.inconvertibleString))
    }
    
    func testGivenElementIsInconvertible_WhenCallingComputeWithoutPriority_ThenWeShouldGetCalcErrorInconvertibleString() {
        var operation = calculator.compute(elements: ["a", Operands.addition.symbol, "1"])
        XCTAssertEqual(operation, .failure(CalcError.inconvertibleString))
        operation = calculator.compute(elements: ["1", Operands.addition.symbol, "a"])
        XCTAssertEqual(operation, .failure(CalcError.inconvertibleString))
    }
    
    // MARK: - Errors not used on calculator class
    func testMoreThanOneOperator() {
        let error = CalcError.moreThanOneOperator
        XCTAssertEqual(error.title, "Ce n'est pas possible d'ajouter un nouveau operateur")
        XCTAssertEqual(error.message, "Un operateur est déja mis!")
    }

}


