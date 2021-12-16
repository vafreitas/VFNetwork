# VFNetwork

[![Build](https://github.com/vafreitas/VFNetwork/actions/workflows/swift.yml/badge.svg)](https://github.com/vafreitas/VFNetwork/actions/workflows/swift.yml)
[![Version](https://img.shields.io/cocoapods/v/VFNetwork.svg?style=flat)](https://cocoapods.org/pods/VFNetwork)
[![License](https://img.shields.io/cocoapods/l/VFNetwork.svg?style=flat)](https://cocoapods.org/pods/VFNetwork)
[![Platform](https://img.shields.io/cocoapods/p/VFNetwork.svg?style=flat)](https://cocoapods.org/pods/VFNetwork)

## Introduction

### VFNetwork is a protocol-oriented network layer that will help you assemble your requests in just a few steps.
### Simple, Fast and Easy :).

## How to use

Basically, you need two files to assemble your requests and put Base_URL, Protocol and Environment in your info.plist.

### Info.plist 

![Yout Plist](Assets/Examples/info-plist.png)

You have 3 types of Environments for you choose.

```swift
enum EnvironmentCase: String {
    case production = "production"
    case sandbox = "sandbox"
    case mock = "mock"
}
```


### HomeAPI.swift

Here you will configure your requests.

```swift

import VFNetwork

enum HomeAPI {
    case joke
    case categories
}

extension HomeAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .joke:
            return .plain("jokes/random")
        case .categories:
            return .plain("jokes/categories")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .joke, .categories:
            return .get
        }
    }
    
    var headers: HTTPHeader {
        .custom([
            .bearer("yourToken"),
            .basic("yourBase64"),
            .header("custom", "header")
        ])
    }
    
    var task: HTTPTask {
        switch self {
        case .joke, .categories:
            return .request
        }
    }
    
```

### HomeService.swift

And here you will execute your requests.

```swift 
import VFNetwork

class HomeService: RequestService<HomeAPI> {
    func getJoke(completion: @escaping (Result<RequestStates<JokeModel>, Error>) -> Void) {
        execute(.joke, responseType: JokeModel.self, completion: completion)
    }
    
    func getCategories(completion: @escaping (Result<RequestStates<CategoryModel>, Error>) -> Void) {
        execute(.categories, responseType: CategoryModel.self, completion: completion)
    }
}

```

### That's it. enjoy...

## Documentation

All documentation can be found in the Documentation folder, including detailed installation instructions for CocoaPods and more.

## Requirements

## Installation

VFNetwork is available through [CocoaPods](https://cocoapods.org). To install
it, simply add to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'

target 'Core' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Core

  pod 'VFNetwork'

end
```

## Author

Victor Freitas | iOS Developer

## License

VFNetwork is available under the MIT license. See the LICENSE file for more info.
