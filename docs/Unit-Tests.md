# Introduction

You can use VFNetwork to test your api call methods.
<br>
<br>
Basically we take the json file that you will create to simulate your response with the **JSONMockOrchestrator** class and simulate a request with this response. Below you will find examples and how it all works.


# Register JSON File

For register your json files in code to simulate responses first you need to create them. you can use that structure for example.

```
tests
└───home
│   └───responses
│       │   jokesSuccess.json
│       │   jokesError.json
│   | HomeViewModelTests.swift
```

and just register. in example below you can find it something like.

```Swift
 mock.register(fileNamed: "jokesSuccess") // status code default 200
 mock.register(fileNamed: "jokesError",  statusCode: 400) // with custom status code
```

# Testing Endpoints

For your unit tests, you just need to follow example below. or see **Example** project in VFNetwork repository.
<br>
<br>
**Important**. You dont need to import VFNetwork in your test class because your project has VFNetwork added in frameworks.

## Example with MVVM.
```Swift
import XCTest
@testable import VFNetwork_Example

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel! = .init()
    var mock: JSONMockOrchestrator!
    
    override func setUp() {
        super.setUp()
        mock = JSONMockOrchestrator()
        let provider = RequestProvider<HomeAPI>()
        provider.executor.orchestrator = mock
        viewModel.service.provider = provider
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
```