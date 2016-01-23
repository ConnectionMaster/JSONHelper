//
//  UIColorTests.swift
//  JSONHelper
//
//  Created by Baris Sencan on 7/11/15.
//  Copyright (c) 2015 Baris Sencan. All rights reserved.
//

import XCTest
import JSONHelper

#if os(iOS) || os(tvOS)

import UIKit

#else

import AppKit

#endif

class ColorTests: XCTestCase {
  let testStringAndResult = ("#ffffff", (r: CGFloat(1), g: CGFloat(1), b: CGFloat(1), a: CGFloat(1)))

  func testStringToColorConversion() {
    #if os(iOS) || os(tvOS)
      var value: UIColor?
    #else
      var value: NSColor?
    #endif
    value <-- (testStringAndResult.0 as Any)
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    value?.getRed(&r, green: &g, blue: &b, alpha: &a)
    XCTAssert(
      (r == testStringAndResult.1.r) && (g == testStringAndResult.1.g) && (b == testStringAndResult.1.b) && (a == testStringAndResult.1.a),
      "String to (UI/NS)Color conversion failed")
  }
}
