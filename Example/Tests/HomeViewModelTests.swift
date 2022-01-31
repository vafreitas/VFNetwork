//
//  HomeViewModelTests.swift
//  VFNetwork_Tests
//
//  Created by Victor Freitas on 16/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import VFNetwork_Example

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel! = .init()
    var mock: JSONMockOrchestrator!
    
    override func setUp() {
        super.setUp()
        
        mock = JSONMockOrchestrator(from: self)
        let provider = RequestProvider<HomeAPI>(orchestrator: mock)
        viewModel.service.apply(provider: provider)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mock = nil
    }
    
    func testJokesSuccess() {
        let expectation = self.expectation(description: "Test jokes with success")
        mock.register(fileNamed: "jokesSuccess")
        viewModel.getJokes { result in
            switch result {
            case let .success(jokes):
                XCTAssertNotNil(jokes)
                expectation.fulfill()
            case .failure:
                XCTFail()
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testJokesFailure() {
        let expectation = self.expectation(description: "Test jokes with failure")
        mock.register(fileNamed: "", statusCode: 400)
        viewModel.getJokes { result in
            switch result {
            case .success:
                XCTFail()
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
