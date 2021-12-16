//
//  HomeAPI.swift
//  VFNetwork_Example
//
//  Created by Victor Freitas on 15/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import VFNetwork

enum HomeAPI {
    case home
    case categories
}

extension HomeAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .home:
            return .plain("jokes/random")
        case .categories:
            return .plain("jokes/categories")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .home, .categories:
            return .get
        }
    }
    
    var headers: HTTPHeader {
        .custom([
            .bearer("asdasdasd")
        ])
    }
    
    var task: HTTPTask {
        switch self {
        case .home, .categories:
            return .request
        }
    }
    
    var cacheable: Bool {
        switch self {
        case .home:
            return false
        case .categories:
            return false
        }
    }
}
