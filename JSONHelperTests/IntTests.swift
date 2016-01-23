//
//  IntTests.swift
//  JSONHelper
//
//  Created by Baris Sencan on 6/29/15.
//  Copyright (c) 2015 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class IntTests: XCTestCase {
  let testInt = 1
  let testFloat = Float(1)
  let testDouble = Double(1)
  let testNSDecimalNumber = NSDecimalNumber(integer: 1)
  let testString = "1"

  func testIntToIntConversion() {
    var value: Int?
    value <-- (testInt as Any)
    XCTAssertEqual(value, testInt, "Int to Int conversion failed")
  }

  func testFloatToIntConversion() {
    var value: Int?
    value <-- (testFloat as Any)
    XCTAssertEqual(value, testInt, "Float to Int conversion failed")
  }

  func testDoubleToIntConversion() {
    var value: Int?
    value <-- (testDouble as Any)
    XCTAssertEqual(value, testInt, "Double to Int conversion failed")
  }

  func testNSDecimalNumberToIntConversion() {
    var value: Int?
    value <-- (testNSDecimalNumber as Any)
    XCTAssertEqual(value, testInt, "NSDecimalNumber to Int conversion failed")
  }

  func testStringToIntConversion() {
    var value: Int?
    value <-- (testString as Any)
    XCTAssertEqual(value, testInt, "String to Int conversion failed")
  }
}
