//
//  CatServiceTests.swift
//  cat factTests
//
//  Created by sushil tiwari on 04/10/24.
//
import XCTest
@testable import cat_fact // Replace with your actual project name

class CatServiceTests: XCTestCase {
    var catService: CatService!

    override func setUp() {
        super.setUp()
        catService = CatService()
    }

    override func tearDown() {
        catService = nil
        super.tearDown()
    }

    func testFetchRandomCatImage_Success() {
        let expectation = self.expectation(description: "Fetch random cat image")
        
        catService.fetchRandomCatImage { catImage in
            XCTAssertNotNil(catImage)
            XCTAssertNotNil(catImage?.url)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchRandomCatFact_Success() {
        let expectation = self.expectation(description: "Fetch random cat fact")
        
        catService.fetchRandomCatFact { catFact in
            XCTAssertNotNil(catFact) // Ensure catFact is not nil
            XCTAssertFalse(catFact!.isEmpty) // Ensure the catFact string is not empty
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
