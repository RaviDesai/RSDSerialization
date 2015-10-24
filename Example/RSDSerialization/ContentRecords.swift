//
//  ContentRecords.swift
//  RSDSerialization
//
//  Created by Ravi Desai on 8/3/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import Foundation
import RSDSerialization

public struct ContentRecords: JSONSerializable {
    public var ResultCount: Int
    public var Results: [Content]
    
    public init(resultCount: Int, results: [Content]) {
        self.ResultCount = resultCount
        self.Results = results
    }
    
    public static func create(resultCount: Int)(results: [Content]) -> ContentRecords {
        return ContentRecords(resultCount: resultCount, results: results)
    }
    
    public func convertToJSON() -> JSONDictionary {
        var dict = JSONDictionary()
        addTuplesIf(&dict,
            tuples: ("resultCount", self.ResultCount),
            ("results", convertToJSONArray(self.Results)))
        return dict
    }
    
    public static func createFromJSON(json: JSON) -> ContentRecords? {
        if let record = json as? JSONDictionary {
            return ContentRecords.create
                <*> record["resultCount"] >>- asInt
                <*> record["results"] >>- ModelFactory<Content>.createFromJSONArray
        }
        return nil
    }
}