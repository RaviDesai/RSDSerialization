//
//  TestModelHelpers.swift
//  RSDSerialization
//
//  Created by Ravi Desai on 10/25/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
import RSDSerialization
import Foundation


class TestJSONHelpers: XCTestCase {
    func testUUID() {
        let uuid = NSUUID()
        let json: JSON = uuid.UUIDString
        let converted = json >>- asUUID
        
        XCTAssertTrue(converted != nil)
        XCTAssertTrue(uuid == converted!)
    }

    func testUUIDWhenNull() {
        var converted = nil >>- asUUID
        XCTAssertTrue(converted == nil)

        converted = 17 >>- asUUID
        XCTAssertTrue(converted == nil)
    }

    func testURL() {
        let url = NSURL(string: "http://itunes.apple.com/search?name=Pink")!
        let json: JSON = url.absoluteString
        let converted = json >>- asUrl

        XCTAssertTrue(converted != nil)
        XCTAssertTrue(url == converted)
    }

    func testURLWhenNull() {
        var converted = nil >>- asUrl
        XCTAssertTrue(converted == nil)

        converted = 17 >>- asUrl
        XCTAssertTrue(converted == nil)
    }

    func testBool() {
        let b = true
        let json: JSON = b
        let converted = json >>- asBool
        
        XCTAssertTrue(converted != nil)
        XCTAssertTrue(converted! == b)
    }
    
    func testInt() {
        let i = 17
        let json: JSON = i
        let converted = json >>- asInt
        
        XCTAssertTrue(converted != nil)
        XCTAssertTrue(converted! == i)
    }
    
    func testDouble() {
        let d = 3.14
        let json: JSON = d
        let converted = json >>- asDouble
        
        XCTAssertTrue(converted != nil)
        XCTAssertEqualWithAccuracy(d, converted!, accuracy: 0.001)
    }
    
    func testString() {
        let s = "value"
        let json: JSON = s
        let converted = json >>- asString
        
        XCTAssertTrue(converted != nil)
        XCTAssertTrue(converted! == s)
    }
    
    func testDate() {
        let d = NSDate(timeIntervalSince1970: 0)
        let json: JSON = d.toUTCString("yyyy-MM-dd'T'HH:mm:ssX")!
        let converted = json >>- asDate("yyyy-MM-dd'T'HH:mm:ssX")
        
        XCTAssertTrue(converted != nil)
        XCTAssertTrue(converted! == d)
    }
    
    func testDateWhenNull() {
        var converted = nil >>- asDate("yyyy-MM-dd'T'HH:mm:ssX")
        XCTAssertTrue(converted == nil)

        converted = 17 >>- asDate("yyyy-MM-dd'T'HH:mm:ssX")
        XCTAssertTrue(converted == nil)
    }
    
    func testDictionary() {
        let d = ["test": "one"]
        let jsonDict: JSONDictionary = d
        let json: JSON = jsonDict
        let converted = json >>- asDictionary
        
        XCTAssertTrue(converted != nil)
        XCTAssertTrue(converted!.count == 1)
        XCTAssertTrue(converted!["test"] as! String == "one")
    }
    
    func testArray() {
        let a = [1, 2, 3]
        let jsonArray: JSONArray = a
        let json: JSON = jsonArray
        let converted = json >>- asArray
        
        XCTAssertTrue(converted != nil)
        XCTAssertTrue(converted!.count == 3)
        XCTAssertTrue(converted![0] as! Int == 1)
        XCTAssertTrue(converted![1] as! Int == 2)
        XCTAssertTrue(converted![2] as! Int == 3)
    }
    
    func testCreateSample() {
        let d = ["S": "stringval", "I": 16]
        let jsonDict: JSONDictionary = d
        let json:JSON = jsonDict
        
        let sample = Sample.createFromJSON(json)
        XCTAssertTrue(sample != nil)
        XCTAssertTrue(sample!.s == "stringval")
        XCTAssertTrue(sample!.i == .Some(16))
    }
    
    func testCreateSampleIIsWrongType() {
        let d = ["S": "stringval", "I": "myintvalue"]
        let jsonDict: JSONDictionary = d
        let json:JSON = jsonDict
        
        let sample = Sample.createFromJSON(json)
        XCTAssertTrue(sample != nil)
        XCTAssertTrue(sample!.s == "stringval")
        XCTAssertTrue(sample!.i == nil)
    }

    func testCreateSampleSIsWrongType() {
        let d = ["S": 34.2, "I": "myintvalue"]
        let jsonDict: JSONDictionary = d
        let json:JSON = jsonDict
        
        let sample = Sample.createFromJSON(json)
        XCTAssertTrue(sample == nil)
    }

}
