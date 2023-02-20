//
//  RequestService.swift
//  IamChuck
//
//  Created by Victor Freitas on 17/11/19.
//  Copyright © 2019 Victor Freitas. All rights reserved.
//

import Foundation

open class RequestService<T: APIBuilder> {
    
    // MARK: Properties
    
    open var provider = RequestProvider<T>()
    
    // MARK: Initializer
    
    public init() {}
    
    // MARK: Provider Methods
    
    public func apply(provider: RequestProvider<T>) {
        self.provider = provider
    }
    
    /**
     Method for execute request.
     
     - Parameters:
         - route: ApiBuilder
         - responseType: Element.Type
     - Returns:
     Result<Element?, Error>, _ response: URLResponse?
     
     */
    open func execute<Element>(_ route: T,
                               responseType: Element.Type, completion: @escaping (Result<Element, Error>) -> Void) where Element: VCodable {
        request(route, responseType: responseType, completion: completion)
    }
    
    /**
     Method for execute request with DispatchGroup Integrated.
     
     - Parameters:
         - route: ApiBuilder
         - responseType: Element.Type
         - group: DispatchGroup
     - Returns:
     Result<Element?, Error>,  _ group: DispatchGroup
     
     */
    open func execute<Element>(_ route: T,
                               responseType: Element.Type,
                               group: DispatchGroup,
                               completion: @escaping (Result<Element, Error>, _ group: DispatchGroup) -> Void) where Element: VCodable {
        group.enter()
        request(route, responseType: responseType) {
            completion($0, group)
        }
    }
    
    /**
     Method for execute request with DispatchSemaphore Integrated.
     
     - Parameters:
         - route: ApiBuilder
         - responseType: Element.Type
         - semaphore: DispatchSemaphore
     - Returns:
     Result<Element?, Error>,  _ semaphore: DispatchSemaphore
     
     */
    open func execute<Element>(_ route: T,
                               responseType: Element.Type,
                               semaphore: DispatchSemaphore,
                               completion: @escaping (Result<Element, Error>, _ semaphore: DispatchSemaphore) -> Void) where Element: VCodable {
        semaphore.wait()
        request(route, responseType: responseType) {
            completion($0, semaphore)
        }
    }
    
    /**
     Method for execute request.
     
     - Parameters:
         - route: ApiBuilder
         - responseType: Element.Type
         - group: DispatchGroup
     - Returns:
     Result<Element?, Error>
     
     */
    private func request<Element>(_ route: T,
                                  responseType: Element.Type,
                                  completion: @escaping (Result<Element, Error>) -> Void) where Element: VCodable {
        provider.request(route) { [weak self] data, response, error in
            guard let self = self else { return }
            
            do {
                try self.provider.verifyData(response, error)
                
                guard let data = data else {
                    debugPrint("VFNetwork: Response Body is nil")
                    return
                }
                
                let model = try JSONDecoder().decode(responseType, from: data)
                
                completion(.success(model))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    /**
     Method for execute a plain request without response body.
     
     - Parameters:
         - route: ApiBuilder
         - responseType: Element.Type
     - Returns:
     (_ response: URLResponse?, _ error: Error?)
     
     */
    func execute(_ route: T, completion: @escaping (Result<URLResponse?, Error>) -> Void) {
        provider.request(route) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            do {
                try self.provider.verifyData(response, error)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    // TODO: Future Release ...
//    func download(_ route: T, completion: @escaping (Result<Data?, Error>) -> Void) {
//        provider.download(route) { data, response, error in
//            if let data {
//                print(data)
//                return
//            }
//            
//            print(error)
//        }
//    }
}
