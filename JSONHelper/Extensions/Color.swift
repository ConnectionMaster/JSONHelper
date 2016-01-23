//
//  Color.swift
//
//  Created by Barış Şencan on 06/29/2015.
//  Copyright © 2015 Barış Şencan
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://github.com/isair/JSONHelper
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

private struct ColorConversionHelper {

  private static func hexStringToRGBA(hexString: String) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var red   = CGFloat(0)
    var green = CGFloat(0)
    var blue  = CGFloat(0)
    var alpha = CGFloat(1)

    if hexString.hasPrefix("#") {
      let index    = hexString.startIndex.advancedBy(1)
      let hex      = hexString.substringFromIndex(index)
      let scanner  = NSScanner(string: hex)
      var hexValue = CUnsignedLongLong(0)

      if scanner.scanHexLongLong(&hexValue) {
        switch (hex.characters.count) {
        case 3:
          red   = CGFloat((hexValue & 0xF00) >> 8) / 15.0
          green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
          blue  = CGFloat(hexValue  & 0x00F)       / 15.0
        case 4:
          red   = CGFloat((hexValue & 0xF000) >> 12) / 15.0
          green = CGFloat((hexValue & 0x0F00) >> 8)  / 15.0
          blue  = CGFloat((hexValue & 0x00F0) >> 4)  / 15.0
          alpha = CGFloat(hexValue  & 0x000F)        / 15.0
        case 6:
          red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
          green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
          blue  = CGFloat(hexValue  & 0x0000FF)        / 255.0
        case 8:
          red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
          green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
          blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
          alpha = CGFloat(hexValue  & 0x000000FF)        / 255.0
        default:
          break
        }
      }
    }
    return (red: red, green: green, blue: blue, alpha: alpha)
  }
}

#if os(iOS) || os(tvOS)

import UIKit

extension UIColor: Convertible {

  public static func convertFromValue<T>(value: T?) -> Self? {
    if let stringValue = value as? String {
      let rgba = ColorConversionHelper.hexStringToRGBA(stringValue)
      return self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    return nil
  }
}

#else

import AppKit

extension NSColor: Convertible {

  public static func convertFromValue<T>(value: T?) -> Self? {
    if let stringValue = value as? String {
      let rgb = ColorConversionHelper.hexStringToRGBA(stringValue)
      return self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1)
    }
    return nil
  }
}

#endif
