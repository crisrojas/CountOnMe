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
    
    func testGivenElementsHasThreeItems_WhenCallingExpressionHasEnoughElements_ThenWeShouldGetTrue() {
       
        var elements = ["1", Operands.addition.symbol]
        XCTAssertFalse(calculator.expressionHaveEnoughElement(elements: elements))
        
        elements = ["1", Operands.addition.symbol, "1"]
        XCTAssertTrue(calculator.expressionHaveEnoughElement(elements: elements))
    }

    func testGivenExpressionHasntEnoughElements_WhenCallingCompute_ThenWeShouldGetAFailure() {
        
        let operation = calculator.compute(elements: ["1"])
        XCTAssertEqual(operation, .failure(CalcError.notEnoughElements))
    }
    
    
    func testGiven1plus1_WhenCallingCompute_ThenWeShouldGet2() {
        let operation = calculator.compute(elements: ["1", Operands.addition.symbol, "1"])
        XCTAssertEqual(operation, .success("2"))
    }
    
    func testGiven2minus1_WhenCallingCompute_ThenWeShouldGet1() {
        let operation = calculator.compute(elements: ["2", Operands.substraction.symbol, "1"])
        XCTAssertEqual(operation, .success("1"))
    }
    
    func testGiven2times2_WhenCallingCompute_ThenWeShouldGet4() {
        let operation = calculator.compute(elements: ["2", Operands.multiplication.symbol, "2"])
        XCTAssertEqual(operation, .success("4"))
    }
    
    func testGiven10divided5_WhenCallingCompute_ThenWeShouldGet2() {
        let operation = calculator.compute(elements: ["10", Operands.division.symbol, "5"])
        XCTAssertEqual(operation, .success("2"))
    }
    
    func testGiven7divided5_WhenCallingCompute_ThenWeShouldGet2dot5() {
        let operation = calculator.compute(elements: ["5", Operands.division.symbol, "2"])
        XCTAssertEqual(operation, .success("2.5"))
    }
    
    func testGivenExpressionIsIncorrect_WhenCallingCompute_ThenWeShouldGetAFailure() {
        let operation = calculator.compute(elements: ["1", "+"])
        XCTAssertEqual(operation, .failure(CalcError.incorrectExpression))
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
    
    // Checks if operands priority order is being respected
    func testGiven1plus1times2_WhenCallingCompute_ThenWeShouldGetThree() {
        let operation = calculator.compute(elements: ["1", Operands.addition.symbol, "1", Operands.multiplication.symbol, "2"])
        XCTAssertEqual(operation, .success("3"))
    }
}
