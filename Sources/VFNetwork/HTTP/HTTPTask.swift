//
//  HTTPTask.swift
//  inWave Back Office
//
//  Created by Victor Alves De Freitas on 26/06/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

public enum HTTPHeader {
    case empty
    case bearer(String)
    case basic(String)
    case header(String, String)
    case custom([HTTPHeader])
    case json
    case formURL
}

extension HTTPHeader {    
    internal var values: [String: String] {
        switch self {
        case let .bearer(token): return ["Authorization": "Bearer " + token]
        case let .basic(base64): return ["Authorization": "Basic " + base64]
        case let .header(key, value): return [key: value]
        case .empty: return [:]
        case let .custom(httpHeaders):
            var values: [String: String] = [:]
            for header in httpHeaders {
                for (key, value) in header.values {
                    values[key] = value
                }
            }
            
            return values
        case .json: return ["Content-Type": "application/json"]
        case .formURL: return ["Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]
        }
    }
}

public enum HTTPTask {
    case request
    case requestEncoder(_ model: VCodable)
    case requestBody(parameters: Parameters?)
    case requestURLParameters(urlParameters: Parameters?)
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?,
        additionalHeaders: [String: String]?)
}
