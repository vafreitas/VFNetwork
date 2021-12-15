//
//  RequestHeader.swift
//  VFNetwork
//
//  Created by Victor Alves De Freitas on 30/06/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

class RequestHeader {
    
    /**
      Enum for http content types
     */
    enum ContentType: String {
        case json = "application/json"
        case urlEncoded = "application/x-www-form-urlencoded"
    }
    
    /**
      Method for generate a "default" http request header based on ContentType choosed.
     
     - Parameters:
        - type: ContentType
     
     - Returns:
        Void
     */
    func `default`(_ type: ContentType) -> [String: String] {
        return ["Content-Type": type.rawValue]
    }
}
