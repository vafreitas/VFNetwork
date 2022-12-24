//
//  VFNetwork.swift
//  Pods-VFNetwork_Example
//
//  Created by Victor Alves de Freitas on 23/12/22.
//

import Foundation

public enum VFNetworkOptions {
    case timeout(Double)
    case cacheable(Bool)
}

public class VFNetwork {
    public static let shared: VFNetwork = .init()
    
    // MARK: Network Properties
    
    var timeout: Double = 30.0
    var cacheable: Bool = false
    
    // MARK: URL Session
    
    var session: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.urlCache = .shared
        config.urlCredentialStorage = nil
        config.httpCookieAcceptPolicy = .always
        config.requestCachePolicy = .reloadRevalidatingCacheData
        config.timeoutIntervalForRequest = .init(VFNetwork.shared.timeout)
        
        if #available(iOS 11.0, *) {
            config.waitsForConnectivity = false
        }
        
        return config
    }()
    
    weak var sessionDelegate: URLSessionDelegate?
    
    // MARK: Configure
    
    public func configure(_ configuration: [VFNetworkOptions]) {
        configuration.forEach { option in
            switch option {
            case let .timeout(time):
                self.timeout = time
            case let .cacheable(cache):
                self.cacheable = cache
            }
        }
    }
    
    // MARK: Custom Methods
    
    public func session(session: () -> URLSessionConfiguration) {
        self.session = session()
    }
}
