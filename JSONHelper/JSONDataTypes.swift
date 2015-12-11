//
//  JSONDataTypes.swift
//  JSONHelper
//
//  Created by Baris Sencan on 10/12/2015.
//  Copyright © 2015 Baris Sencan. All rights reserved.
//

import Foundation

// Reference: http://www.json.org

/// See **[here](http://www.json.org)**.
public typealias JSONObject = [String: JSONValue]

/// See **[here](http://www.json.org)**.
public typealias JSONArray = [JSONValue]

/// See **[here](http://www.json.org)**.
public typealias JSONValue = AnyObject

/// See **[here](http://www.json.org)**.
public typealias JSONString = String

/// See **[here](http://www.json.org)**.
public typealias JSONNumber = Double

/// See **[here](http://www.json.org)**.
public typealias JSONBool = Bool

/// See **[here](http://www.json.org)**.
public typealias JSONNull = NSNull
