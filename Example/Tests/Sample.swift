//
//  Sample.swift
//  RSDSerialization
//
//  Created by Ravi Desai on 10/25/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation
import RSDSerialization

struct Sample: JSONSerializable, Equatable {
    var s: String
    var i: Int?
    init(s: String, i: Int?) {
        self.s = s
        self.i = i
    }
    
    static func create(s: String)(i: Int?) -> Sample {
        return Sample(s: s, i: i)
    }
    
    static func createFromJSON(json: JSON) -> Sample? {
        if let record = json as? JSONDictionary {
            return Sample.create
                <*> record["S"] >>- asString
                <**> record["I"] >>- asInt
        }
        return nil
    }
    
    func convertToJSON() -> JSONDictionary {
        var dict = JSONDictionary()
        addTuplesIf(&dict,
            tuples: ("S", self.s), ("I", self.i))
        return dict
    }
}

func== (lhs: Sample, rhs: Sample) -> Bool {
    return lhs.s == rhs.s && lhs.i == rhs.i
}
