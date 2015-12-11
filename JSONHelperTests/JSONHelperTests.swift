//
//  JSONHelperTests.swift
//  JSONHelperTests
//
//  Created by Baris Sencan on 28/08/14.
//  Copyright (c) 2014 Baris Sencan. All rights reserved.
//

import UIKit
import XCTest
import JSONHelper

class JSONHelperTests: XCTestCase {
  let dummyResponse: JSONObject = [
    "date": "2014-09-19",
    "url": "http://github.com/",
    "stringArray": ["a", "b", "c"],
    "intArray": [1, 2, 3, 4, 5],
    "boolArray": [true, false],
    "instance": [
      "name": "b"
    ],
    "instanceArray": [
      [
        "name": "c"
      ], [
        "name": "d"
      ]
    ],
    "instanceMap": [
        "ePerson": [
            "name": "e"
        ],
        "fPerson": [
            "name": "f"
        ]
    ]
  ]

  struct Person: Deserializable {
    var name = ""

    init(jsonObject: JSONObject) {
      name <-- jsonObject["name"]
    }

    init() {}
  }

  enum EnumTest: Int {
    case Zero = 0
    case One = 1
  }

//  func testOptionalNSDate() {
//    var property: NSDate?
//    property <-- (dummyResponse["date"], "yyyy-MM-dd")
//    let dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    let testDate = dateFormatter.dateFromString("2014-09-19")!
//    XCTAssertEqual(property!.compare(testDate), .OrderedSame, "NSDate? property should equal 2014-09-19")
//    property <-- dummyResponse["invalidKey"]
//    XCTAssertNil(property, "NSDate? property should equal nil after invalid assignment")
//  }
//
//  func testNSDate() {
//    let dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    let defaultTestDate = dateFormatter.dateFromString("2015-09-19")
//    var property = defaultTestDate!
//    property <-- (dummyResponse["invalidKey"], "yyyy-MM-dd")
//    XCTAssertEqual(property.compare(defaultTestDate!), .OrderedSame, "NSDate should have the default value 2015-09-19")
//    property <-- (dummyResponse["date"], "yyyy-MM-dd")
//    let testDate = dateFormatter.dateFromString("2014-09-19")!
//    XCTAssertEqual(property.compare(testDate), .OrderedSame, "NSDate should have the value 2015-09-19")
//  }
//
//  func testOptionalNSURL() {
//    var property: NSURL?
//    property <-- dummyResponse["url"]
//    XCTAssertEqual(property!.host!, "github.com", "NSURL? property should equal github.com")
//    property <-- dummyResponse["invalidKey"]
//    XCTAssertNil(property, "NSURL? property should equal nil after invalid assignment")
//  }
//
//  func testNSURL() {
//    var property = NSURL(string: "http://google.com")!
//    property <-- dummyResponse["invalidKey"]
//    XCTAssertEqual(property.host!, "google.com", "NSURL should have the default value google.com")
//    property <-- dummyResponse["url"]
//    XCTAssertEqual(property.host!, "github.com", "NSURL should have the value github.com")
//  }
//
//  func testStringArray() {
//    var property = [String]()
//    property <-- dummyResponse["stringArray"]
//    XCTAssertEqual(property.count, 3, "[String] property should have 3 members")
//  }
//
//  func testIntArray() {
//    var property = [Int]()
//    property <-- dummyResponse["intArray"]
//    XCTAssertEqual(property.count, 5, "[Int] property should have 5 members")
//  }
//
//  func testBoolArray() {
//    var property = [Bool]()
//    property <-- dummyResponse["boolArray"]
//    XCTAssertEqual(property.count, 2, "[Bool] property should have 2 members")
//  }
//
//  // TODO: Test [NSDate]
//
//  // TODO: Test [NSURL]
//
//  func testInstance() {
//    var instance = Person()
//    instance <-- dummyResponse["instance"]
//    XCTAssertEqual(instance.name, "b", "Person instance's name property should equal 'b'")
//  }
//
//  func testInstanceArray() {
//    var property = [Person]()
//    property <-- dummyResponse["instanceArray"]
//    XCTAssertEqual(property.count, 2, "[Person] property should have 2 members")
//  }
//
//  func testJSONStringToInstance() {
//    let name = "Bob"
//    var person: Person?
//    person <-- "{\"name\": \"\(name)\"}"
//    XCTAssert(person?.name == name, "Person instance's name property should equal '\(name)'")
//  }
//
//  func testJSONStringToInstanceArray() {
//    let jsonString = "[{\"name\": \"I am \"},{\"name\": \"Groot!\"}]"
//    var people = [Person]()
//    people <-- jsonString
//    var areYouGroot = ""
//    for person in people {
//      areYouGroot += person.name
//    }
//    XCTAssertEqual(areYouGroot, "I am Groot!", "Groot should be Groot")
//  }
//
//  func testInstanceMap() {
//    var property = [String:Person]()
//    property <-- dummyResponse["instanceMap"]
//    XCTAssertEqual(property["ePerson"]!.name, "e", "member \"ePerson\" of [String:Person] property should have \"e\" for name")
//  }
//
//  func testRawValueEnum() {
//    var property = EnumTest.Zero
//    property <-- dummyResponse["int"]
//    XCTAssertEqual(property, EnumTest.One, "EnumTest should be equal to .One")
//  }
//
//  func testJSONStringMapParsing() {
//    var jsonString = "{\"person one\": {\"name\": \"I am \"}, \"person two\": {\"name\": \"Groot!\"}}"
//    var jsonObject: JSONObject? = JSONStringToJSONObject(jsonString)
//    var people = [String:Person]()
//    var areYouGroot = ""
//    var keys = ""
//    
//    people <-- jsonObject
//    
//    for (personKey, person) in people {
//      areYouGroot += person.name
//      keys += personKey
//    }
//    
//    XCTAssertEqual(keys, "person oneperson two", "keys should be correctly picked up")
//    XCTAssertEqual(areYouGroot, "I am Groot!", "Groot should be Groot")
//  }
//
//  func testJSONIntObjectMap() {
//    var jsonString = "{\"1\": {\"name\": \"Grace\"}, \"2\": {\"name\": \"Lancy\"}}"
//    var jsonObject: JSONObject? = JSONStringToJSONObject(jsonString)
//    var people = [Int: Person]()
//
//    people <-- jsonObject
//
//    XCTAssertEqual(people[1]!.name, "Grace", "people[1] should be Grace")
//    XCTAssertEqual(people[2]!.name, "Lancy", "people[2] should be Lancy")
//  }
//
//  func testJSONIntIntMap() {
//    var jsonString = "{\"1\": 1, \"2\": 2}"
//    var jsonObject: JSONObject? = JSONStringToJSONObject(jsonString)
//    var dict = [Int: Int]()
//
//    dict <-- jsonObject
//
//    XCTAssertEqual(dict[1]!, 1, "dict[1] should be 1")
//    XCTAssertEqual(dict[2]!, 2, "dict[2] should be 2")
//  }
}
