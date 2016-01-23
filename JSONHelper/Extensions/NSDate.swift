//
//  NSDate.swift
//
//  Created by Barış Şencan on 06/01/2015.
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

import Foundation

extension NSDate: Convertible {
  private static let sharedFormatter = NSDateFormatter()

  public static func convertFromValue<T>(value: T?) -> Self? {
    guard let value = value else { return nil }

    if let unixTimeStamp = value as? NSTimeInterval {
      return self.init(timeIntervalSince1970: unixTimeStamp)
    } else if let
      jsonDictionaryValueAndFormatTuple = value as? (AnyObject?, String),
      stringValue = jsonDictionaryValueAndFormatTuple.0 as? String {
        sharedFormatter.dateFormat = jsonDictionaryValueAndFormatTuple.1
        if let convertedDate = sharedFormatter.dateFromString(stringValue) {
          return self.init(timeIntervalSince1970: convertedDate.timeIntervalSince1970)
        }
    } else if let
      jsonDictionaryValueAndConversionClosureTuple = value as? (AnyObject?, (value: AnyObject) -> NSDate?),
      jsonDictionaryValue: AnyObject = jsonDictionaryValueAndConversionClosureTuple.0,
      convertedDate = jsonDictionaryValueAndConversionClosureTuple.1(value: jsonDictionaryValue) {
        return self.init(timeIntervalSince1970: convertedDate.timeIntervalSince1970)
    }
    return nil
  }
}
