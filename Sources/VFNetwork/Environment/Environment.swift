//
//  Environment.swift
//  VFNetwork
//
//  Created by Victor Alves De Freitas on 01/07/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

public enum PlistKey {
    case baseURL
    case environment
    case httpProtocol
    
    func value() -> String {
        switch self {
        case .baseURL:
            return "Base_URL"
        case .environment:
            return "Environment"
        case .httpProtocol:
            return "Protocol"
        }
    }
}

/**
 Create a structure for diferent environments in application

 - Note:
        This structure get configurations in .xcconfig file at folder Config based in choosed scheme.
 */
public struct Environment {
    
    fileprivate var infoDict: [String: Any] {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            } else {
                fatalError("Plist file not found")
            }
        }
    }
    
    /**
     Get the configuration based in PlistKeyEnum
        
    - Parameters:
     - key: PlistKey
    
    - Returns:
            the value of PlistKey choosed.
     */
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .baseURL:
            guard let httpProtocol = infoDict[PlistKey.httpProtocol.value()] as? String,
                let baseURL = infoDict[PlistKey.baseURL.value()] as? String else {
                fatalError("Base url is nil")
            }
            return "\(httpProtocol)://\(baseURL)/"
        case .environment:
            if let environment =  infoDict[PlistKey.environment.value()] as? String {
                return environment
            } else {
                return ""
            }
        case .httpProtocol:
            if let httpProtocol = infoDict[PlistKey.httpProtocol.value()] as? String {
                return httpProtocol
            } else {
                return ""
            }
        }
    }
}
