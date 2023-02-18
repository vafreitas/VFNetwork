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
    case pdf
}

extension HomeAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .home:
            return .plain("jokes/random")
        case .categories:
            return .plain("jokes/categories")
        case .pdf:
            return .plain("https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .home, .categories, .pdf:
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
        case .home, .categories, .pdf:
            return .request
        }
    }
}
