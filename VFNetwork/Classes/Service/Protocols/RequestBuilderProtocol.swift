//
//  RequestExecutor.swift
//  inWave Back Office
//
//  Created by Victor Alves De Freitas on 26/06/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

// MARK: Typealias

typealias CompletionHandlerPlain = (_ response: URLResponse?,
                                    _ error: Error?) -> Void

typealias NetworkRouterCompletion = (_ data: Data?,
                                     _ response: URLResponse?,
                                    _ error: Error?) -> Void

// MARK: Global Enums
public enum RequestStates<E> {
     case load(E)
     case cache(E)
 }

// MARK: Protocol

protocol RequestBuilderProtocol: class {
    associatedtype ApiBuilder: APIBuilder
    func request(_ route: ApiBuilder, completion: @escaping NetworkRouterCompletion)
}
