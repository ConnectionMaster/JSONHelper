//
//  Color.swift
//  JSONHelper
//
//  Created by Baris Sencan on 6/29/15.
//  Copyright (c) 2015 Baris Sencan. All rights reserved.
//

private struct ColorConversionHelper {

  private static func hexStringToRGB(hexString: String) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    let trimmedString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    let scanner = NSScanner(string: trimmedString)
    if trimmedString.hasPrefix("#") {
      scanner.scanLocation = 1
    }
    var color:UInt32 = 0
    scanner.scanHexInt(&color)
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0
    return (red: red, green: green, blue: blue)
  }
}

#if os(iOS)

import UIKit

extension UIColor: Convertible {

  public static func convertFromValue(value: Any?) -> Self? {
    if let stringValue = value as? String {
      let rgb = ColorConversionHelper.hexStringToRGB(stringValue)
      return self(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1)
    }
    return nil
  }
}

#else

import AppKit

extension NSColor: Convertible {

  public static func convertFromValue(value: Any?) -> Self? {
    if let stringValue = value as? String {
      let rgb = ColorConversionHelper.hexStringToRGB(stringValue)
      return self(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1)
    }
    return nil
  }
}

#endif
