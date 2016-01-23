//
//  Conversion.swift
//
//  Created by Barış Şencan on 01/22/2016.
//  Copyright © 2016 Barış Şencan
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

import Foundation

/// Operator for use in right hand side to left hand side conversion.
infix operator <-- { associativity right precedence 150 }

/// Operator for use in left hand side to right hand side conversion.
infix operator --> { associativity left precedence 150 }

/// Filters out values of type NSNull.
///
/// :param: value Value to check.
///
/// :returns: nil if value is of type NSNull, else the value is returned as-is.
public func convertToNilIfNull<T>(value: T?) -> T? {
  if value is NSNull {
    return nil
  }
  return value
}

/// An object that can attempt to convert values of unknown types to its own type.
public protocol Convertible {

  /// TODOC
  static func convertFromValue<T>(value: T?) -> Self?
}

public func <-- <C: Convertible, T>(inout lhs: C?, rhs: T?) -> C? {
  lhs = C.convertFromValue(convertToNilIfNull(rhs))
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: C, rhs: T?) -> C {
  var newValue: C?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [C]?, rhs: T?) -> [C]? {
  if let array = rhs as? [AnyObject] {
    lhs = [C]()
    for element in array {
      var convertedElement: C?
      convertedElement <-- element
      if let convertedElement = convertedElement {
        lhs?.append(convertedElement)
      }
    }
  } else {
    lhs = nil
  }
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [C], rhs: T?) -> [C] {
  var newValue: [C]?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [String: C]?, rhs: T?) -> [String: C]? {
  if let dictionary = rhs as? JSONObject {
    lhs = [String: C]()
    for (key, value) in dictionary {
      var convertedValue: C?
      convertedValue <-- value
      if let convertedValue = convertedValue {
        lhs?[key] = convertedValue
      }
    }
  } else {
    lhs = nil
  }
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [String: C], rhs: T?) -> [String: C] {
  var newValue: [String: C]?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

public func --> <C: Convertible, T>(lhs: T?, inout rhs: C?) -> C? {
  return rhs <-- lhs
}

public func --> <C: Convertible, T>(lhs: T?, inout rhs: C) -> C {
  return rhs <-- lhs
}

public func --> <C: Convertible, T>(lhs: T?, inout rhs: [C]?) -> [C]? {
  return rhs <-- lhs
}

public func --> <C: Convertible, T>(lhs: T?, inout rhs: [C]) -> [C] {
  return rhs <-- lhs
}
