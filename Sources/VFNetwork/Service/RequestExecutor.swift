//
//  RequestDataTask.swift
//  IamChuck
//
//  Created by Victor Freitas on 17/11/19.
//  Copyright © 2019 Victor Freitas. All rights reserved.
//

import Foundation

enum TimeoutRequestType: TimeInterval {
    case normal = 30.0
    case long = 60.0
}

open class RequestExecutor: NSObject {
    
    // MARK: Properties
    
    public var orchestrator: RequestOrchestratorProtocol
    private var network: VFNetwork = VFNetwork.shared
        
    // MARK: Initializers
    
    override init() {
        orchestrator = RequestOrchestrator()
    }
    
    // MARK: Perform Methods
    
    /**
    Method for perform a  request with specific orchestrator.
    
    - Parameters:
        - request: URLRequest
     
    - Returns:
    ( _ data: Data?, _ response: URLResponse?, _ error: Error?)
    
    */
    func perform(_ request: URLRequest, completion: @escaping NetworkRouterCompletion) {
        let urlSession = URLSession(configuration: network.session, delegate: network.sessionDelegate, delegateQueue: .main)
        orchestrator.execute(request: request, in: urlSession, completion: completion)
        urlSession.finishTasksAndInvalidate()
    }
}
