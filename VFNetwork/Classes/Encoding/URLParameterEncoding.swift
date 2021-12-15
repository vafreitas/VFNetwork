//
//  URLParameterEncoding.swift
//  inWave Back Office
//
//  Created by Victor Alves De Freitas on 26/06/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

/**
 For create URLParameterEncoding for request.
 */
public struct URLParameterEncoding: ParameterEncoder {
    
    /**
     For encode xxx-urlencoded
     - Parameters:
        - urlRequest: inout URLRequest
        - parameters: Parameters
     */
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)"
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
