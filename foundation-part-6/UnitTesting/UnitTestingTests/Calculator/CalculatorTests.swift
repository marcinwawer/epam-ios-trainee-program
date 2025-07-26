//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }
    
    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        let positive = try calculator.divide(10, 2)
        let fraction = try calculator.divide(7, 2)
        let dividePositiveByFraction = try calculator.divide(5, 2.5)
        let negativeFirst = try calculator.divide(-10, 2)
        let negativeSecond = try calculator.divide(10, -2)
        let negativeBoth = try calculator.divide(-10, -2)
        let zero = try calculator.divide(0, 5)
        
        XCTAssertEqual(positive, 5)
        XCTAssertEqual(fraction, 3.5)
        XCTAssertEqual(dividePositiveByFraction, 2)
        XCTAssertEqual(negativeFirst, -5)
        XCTAssertEqual(negativeSecond, -5)
        XCTAssertEqual(negativeBoth, 5)
        XCTAssertEqual(zero, 0)
    }

    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    // use XCTAssertThrowsError, XCTAssertEqual
    func test_divideByZero_throwsError() {
        let divideTenByZero = { try self.calculator.divide(10, 0) }
        let divideZeroByZero = { try self.calculator.divide(0, 0) }
        
        XCTAssertThrowsError(try divideTenByZero()) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .divisionByZero)
        }

        XCTAssertThrowsError(try divideZeroByZero()) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .divisionByZero)
        }
    }

    // Check 3 scenarios: < 10, 10, > 10
    // use XCTAssertTrue, XCTAssertFalse
    func test_isGreaterThanTen() {
        let smaller = calculator.isGreaterThanTen(5)
        let equal = calculator.isGreaterThanTen(10)
        let greater = calculator.isGreaterThanTen(15)
        
        XCTAssertFalse(smaller)
        XCTAssertFalse(equal)
        XCTAssertTrue(greater)
    }

    // Use XCTAssertNotNil and/or XCAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        let sqrt4 = calculator.safeSquareRoot(4)
        let sqrt2 = calculator.safeSquareRoot(2)
        let sqrt0 = calculator.safeSquareRoot(0)
        
        XCTAssertNotNil(sqrt4)
        XCTAssertEqual(sqrt4!, 2)
        
        XCTAssertNotNil(sqrt2)
        XCTAssertEqual(sqrt2!, sqrt(2))
        
        XCTAssertNotNil(sqrt0)
        XCTAssertEqual(sqrt0!, 0)
    }

    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        let negative = calculator.safeSquareRoot(-1)
        let negativeDecimal = calculator.safeSquareRoot(-100.5)
        
        XCTAssertNil(negative)
        XCTAssertNil(negativeDecimal)
    }
}
