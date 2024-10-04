//
//  CatViewModelTests.swift
//  cat factTests
//
//  Created by sushil tiwari on 04/10/24.
//
import XCTest
@testable import cat_fact // Replace with your actual project name

class CatViewModelTests: XCTestCase {
    var viewModel: CatViewModel!
    var catService: CatService!

    override func setUp() {
        super.setUp()
        catService = CatService()
        viewModel = CatViewModel(catService: catService)
    }

    override func tearDown() {
        viewModel = nil
        catService = nil
        super.tearDown()
    }

    
    
    func testFetchNewCatContent_UpdatesCatImageURL() {
        let expectation = self.expectation(description: "Fetch new cat content updates cat image URL")
        viewModel.updateUI = {
            XCTAssertNotNil(self.viewModel.catImageURL)
            XCTAssertTrue(self.viewModel.catImageURL!.count > 0)
            expectation.fulfill()
        }
        
        viewModel.fetchNewCatContent()
        waitForExpectations(timeout: 5, handler: nil)
    }
    


}
