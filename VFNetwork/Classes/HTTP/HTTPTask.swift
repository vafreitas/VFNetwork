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
}

public enum HTTPTask {
    case request
    case requestEncoder(_ model: ICodable)
    case requestBody(parameters: Parameters?)
    case requestURLParameters(urlParameters: Parameters?)
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?,
        additionalHeaders: [String: String]?)
}
