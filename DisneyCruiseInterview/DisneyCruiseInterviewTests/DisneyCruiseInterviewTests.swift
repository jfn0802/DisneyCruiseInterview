//
//  DisneyCruiseInterviewTests.swift
//  DisneyCruiseInterviewTests
//
//  Created by Jonathan Nammour on 5/18/22.
//

import XCTest
@testable import DisneyCruiseInterview

class DisneyCruiseInterviewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecodeComicAPI() throws {
        let jsonData = try Data(contentsOf: Bundle.main.url(forResource: "testingComicAPI_success", withExtension: "json")!)
        XCTAssertNoThrow(try JSONDecoder().decode(MarvelAPI_comics_codable.self, from: jsonData))
    }
    
    func testFetchCatDetails () {
         
         let handlerExpectation = expectation(description: "waited")
        marvelAPI_comics_get(format: nil, characterID: nil) { comic in
            if comic?.code == 200 {
                handlerExpectation.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        let result = XCTWaiter().wait(for: [handlerExpectation], timeout: 5)
        XCTAssert(result == .completed)
    }
}
