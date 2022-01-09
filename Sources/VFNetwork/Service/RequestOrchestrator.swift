//
//  RequestOrchestrator.swift
//  IamChuck
//
//  Created by Victor Freitas on 17/11/19.
//  Copyright © 2019 Victor Freitas. All rights reserved.
//

import Foundation

class RequestOrchestrator: RequestOrchestratorProtocol {
    
    /**
    Method for execute a  request with specific session.
    
    - Parameters:
    - request: URLRequest
    - session: URLSession
     
    - Returns:
    ( Data?, URLResponse?,  APIError?)
    
    */
    func execute(request: URLRequest, in session: URLSession, completion: @escaping (Data?, URLResponse?, APIError?) -> Void) {
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let error = error else {
                completion(data, response, nil)
                return
            }
            completion(nil, response, APIError.unknown(error))
        }).resume()
    }
}
