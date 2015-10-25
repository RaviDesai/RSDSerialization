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

class TestModelHelpers: XCTestCase {
    func testSampleSerializeDeserialize() {
        let sample = Sample(s: "test", i: 12)
        let json = sample.convertToJSON()
        
        let deserializedSample = Sample.createFromJSON(json)
        XCTAssertTrue(sample == deserializedSample)
    }
    
    func testSampleSerializeToFormURL() {
        let sample = Sample(s: "test", i: 12)
        let formUrl = sample.convertToFormUrlEncoded()
        let formUrlString = String(data: formUrl, encoding: NSUTF8StringEncoding)!
        XCTAssertTrue(formUrlString == "S=test&I=12")
    }
    
    func testSampleSerializeArray() {
        let sampleArray = [Sample(s: "one", i: 1), Sample(s: "two", i: 2)]
        let json = convertToJSONArray(sampleArray)!
        
        let converted = ModelFactory<Sample>.createFromJSONArray(json)
        XCTAssertTrue(converted != nil)
        XCTAssertTrue(sampleArray == converted!)
    }
    
    func testConvertToJSONArrayWithNull() {
        let sampleArray: [Sample]? = nil
        let converted = convertToJSONArray(sampleArray)
        XCTAssertTrue(converted == nil)
    }
    
    func testCreateFromJSONArrayWhenNotPassedArray() {
        let jsonDict = JSONDictionary()
        let json: JSON = jsonDict
        
        let sampleArray = ModelFactory<Sample>.createFromJSONArray(json)
        XCTAssertTrue(sampleArray == nil)
    }
}