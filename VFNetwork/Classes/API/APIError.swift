//
//  APIError.swift
//  inwave
//
//  Created by Victor Alves De Freitas on 03/07/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

public protocol APIErrorProtocol: LocalizedError {
    var errorDescription: String? { get }
}
/**
 For some know errors
 */
public enum APIError: Error {
    case unauthorized(Error?)
    case forbidden(Error?)
    case badRequest(Error?)
    case internalError(Error?)
    case notFound(Error?)
    case unknown(Error?)
}

extension APIError: APIErrorProtocol {
    public var errorDescription: String? {
        switch self {
        case .unauthorized(let error):
            return generateErrorBasedOn(preffix: "Unauthorized", error)
        case .badRequest(let error):
            return generateErrorBasedOn(preffix: "Bad request", error)
        case .forbidden(let error):
            return generateErrorBasedOn(preffix: "Forbidden", error)
        case .internalError(let error):
            return generateErrorBasedOn(preffix: "Internal server error", error)
        case .notFound(let error):
            return generateErrorBasedOn(preffix: "Not founded", error)
        case .unknown(let error):
            return generateErrorBasedOn(preffix: "Unknown error", error)
        }
    }
    
    /**
     Generate description of error
        
     - Parameters:
        - preffix: String
        - error: Error?
     - Returns:
        -  String
     
     */
    func generateErrorBasedOn(preffix: String, _ error: Error?) -> String {
        return NSLocalizedString("\(preffix)\(error?.localizedDescription ?? "")", comment: "")
    }
}
