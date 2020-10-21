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
        XCTAssert(calculator.expressionIsCorrect(elements: ["1"]))
    }
    
    func testGivenElementsHasThreeItems_WhenCallingExpressionHasEnoughElements_ThenWeShouldGetTrue() {
       
        var elements = ["1", "+"]
        XCTAssertFalse(calculator.expressionHaveEnoughElement(elements: elements))
        
        elements = ["1", "+", "1"]
        XCTAssert(calculator.expressionHaveEnoughElement(elements: elements))
    }

    func testGivenExpressionHasntEnoughElements_WhenCallingCompute_ThenWeShouldGetAFailure() {
        
        let operation = calculator.compute(elements: ["1"])
        XCTAssertEqual(operation, .failure(CalcError.notEnoughElements))
    }
    
    func testGiven1plus1_WhenCallingCompute_ThenWeShouldGet2() {
        let operation = calculator.compute(elements: ["1", "+", "1"])
        XCTAssertEqual(operation, .success("2.0"))
    }
    
    func testGiven2minus1_WhenCallingCompute_ThenWeShouldGet1() {
        let operation = calculator.compute(elements: ["2", "-", "1"])
        XCTAssertEqual(operation, .success("1.0"))
    }
    
    func testGiven2times2_WhenCallingCompute_ThenWeShouldGet4() {
        let operation = calculator.compute(elements: ["2", "x", "2"])
        XCTAssertEqual(operation, .success("4.0"))
    }
    
    func testGiven10divided5_WhenCallingCompute_ThenWeShouldGet2() {
        let operation = calculator.compute(elements: ["10", "÷", "5"])
        XCTAssertEqual(operation, .success("2.0"))
    }
    
    func testGivenExpressionIsIncorrect_WhenCallingCompute_ThenWeShouldGetAFailure() {
        let operation = calculator.compute(elements: ["1", "+"])
        XCTAssertEqual(operation, .failure(CalcError.incorrectExpression))
    }
}
