//
//  Mapping.swift
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

/// TODOC
public protocol Deserializable {

  /// TODOC
  init(jsonObject: JSONObject)
}

/// TODOC
public protocol Serializable {

  /// TODOC
  func toJSONValue() -> JSONValue
}

public func <-- <D: Deserializable, T>(inout lhs: D?, rhs: T?) -> D? {
  let cleanedValue = convertToNilIfNull(rhs)
  if let jsonObject = cleanedValue as? JSONObject {
    lhs = D(jsonObject: jsonObject)
  } else if let string = cleanedValue as? String {
    lhs <-- dataStringToObject(string)
  } else {
    lhs = nil
  }
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: D, rhs: T?) -> D {
  var newValue: D?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: [D]?, rhs: T?) -> [D]? {
  if let array = rhs as? [AnyObject] {
    lhs = [D]()
    for element in array {
      var convertedElement: D?
      convertedElement <-- element
      if let convertedElement = convertedElement {
        lhs?.append(convertedElement)
      }
    }
  } else if let string = convertToNilIfNull(rhs) as? String {
    lhs <-- dataStringToObject(string)
  } else {
    lhs = nil
  }
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: [D], rhs: T?) -> [D] {
  var newValue: [D]?
  newValue <-- rhs
  if let newValue = newValue {
    lhs = newValue
  }
  return lhs
}

// MARK: - Helper methods

private func dataStringToObject(dataString: String) -> AnyObject? {
  guard let data: NSData = dataString.dataUsingEncoding(NSUTF8StringEncoding) else { return nil }
  var jsonObject: AnyObject?
  do {
    jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
  } catch {}
  return jsonObject
}
