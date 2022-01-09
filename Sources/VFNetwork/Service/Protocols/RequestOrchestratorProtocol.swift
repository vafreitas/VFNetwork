//
//  RequestOrchestratorProtocol.swift
//  IamChuck
//
//  Created by Victor Freitas on 17/11/19.
//  Copyright © 2019 Victor Freitas. All rights reserved.
//

import Foundation

public protocol RequestOrchestratorProtocol: AnyObject {
    func execute(request: URLRequest,
    in session: URLSession,
    completion: @escaping (Data?, URLResponse?, APIError?) -> Void)
}
