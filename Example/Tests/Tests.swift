import UIKit
import XCTest
import RSDSerialization
import Foundation

class Tests: XCTestCase {
    
    func getiTunesData() -> NSData? {
        var result: NSData?
        let bundle = NSBundle(forClass: Tests.classForCoder())
        if let iTunesResultsPath = bundle.pathForResource("iTunesResults", ofType: "json") {
            result = NSData(contentsOfFile: iTunesResultsPath)
        }
        return result
    }
    
    func getiTunesResults() -> ContentRecords? {
        var result: ContentRecords?
        if let data = self.getiTunesData() {
            let json: JSON? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            if let jsonDictionary: JSON = json {
                result = ModelFactory<ContentRecords>.createFromJSON(jsonDictionary)
            }
        }
        return result
    }
    
    var contentRecords: ContentRecords?
    
    override func setUp() {
        super.setUp()
        self.contentRecords = self.getiTunesResults()
        XCTAssertTrue(self.contentRecords != nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testResultCount() {
        XCTAssert(contentRecords?.ResultCount == 50, "resultcount should be 50")
        XCTAssert(contentRecords?.Results.count ==  50, "there should be 50 actual records")
    }
    
    func testExplicitness() {
        let collectionExplicitnessArray = contentRecords?.Results.map { $0.CollectionExplicitness }.filter { $0 == ContentExplicitness.NotExplicit }
        XCTAssert(collectionExplicitnessArray?.count == .Some(50), "none of the 50 should be explicit")
    }
    
    func testReleaseDates() {
        let releaseDates = contentRecords?.Results.map { $0.ReleaseDate }.filter { $0 == toDateFromString("yyyy-MM-dd'T'HH:mm:ssX", dateString: "2011-09-23T07:00:00Z") }
        XCTAssert(releaseDates?.count == .Some(44), "6 records have different dates")
        
        let releaseDateForFirstRecord = contentRecords?.Results.map { $0.ReleaseDate }.first
        let firstRecordDate = toStringFromDate("yyyy-MM-dd'T'HH:mm:ssX", dateOptional: releaseDateForFirstRecord)
        XCTAssert(firstRecordDate == "2011-09-23T07:00:00Z", "date for first record wrong")

        let releaseDateForLastRecord = contentRecords?.Results.map { $0.ReleaseDate }.last
        let lastRecordDate = toStringFromDate("yyyy-MM-dd'T'HH:mm:ssX", dateOptional: releaseDateForLastRecord)
        XCTAssert(lastRecordDate == "2011-09-23T07:00:00Z", "date for last record wrong")
    }
    
    func testArtistName() {
        let artistNames = contentRecords?.Results.map { $0.ArtistName }.filter { $0 == "Pink Floyd" }
        XCTAssert(artistNames?.count == .Some(50), "which one's not pink?")
    }
    
    func testPreviewURL() {
        let previewURL = contentRecords?.Results.map { $0.PreviewURL }.first
        XCTAssert(previewURL != nil)
        XCTAssert(previewURL??.absoluteString == .Some("http://a1626.phobos.apple.com/us/r1000/030/Music6/v4/e0/38/1d/e0381d61-42fa-9f05-4ef9-47869d5f0eec/mzaf_5336350570700489631.plus.aac.p.m4a"))
    }
}
