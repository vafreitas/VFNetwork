//
//  RequestBuilder.swift
//  inWave Back Office
//
//  Created by Victor Alves De Freitas on 26/06/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

open class RequestProvider<ApiBuilder: APIBuilder>: RequestBuilderProtocol {
    
    // MARK: Properties
    
    public var executor: RequestExecutor
    private var environment: Environment
    private var envConfig: String
    
    // MARK: Initializers
    
    public init() {
        self.executor = RequestExecutor()
        self.environment = Environment()
        self.envConfig = environment.configuration(.environment)
    }
    
    // MARK: Provider Methods
    
    public init(orchestrator: RequestOrchestratorProtocol) {
        self.executor = RequestExecutor()
        self.executor.orchestrator = orchestrator
        self.environment = Environment()
        self.envConfig = environment.configuration(.environment)
    }
    
    // MARK: Enums
    
    enum EnvironmentCase: String {
        case production = "production"
        case sandbox = "sandbox"
        case mock = "mock"
    }
    
    /**
        Method to execute a request after it has been created.
    
    - Parameters:
       - route: ApiBuilder
       - responseType: Element.Type
    - Returns:
        (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
     
     */
    public func request(_ route: ApiBuilder, completion: @escaping NetworkRouterCompletion) {
        let requestLogger = RequestLogger<ApiBuilder>()
        do {
            let request = try self.buildRequest(from: route)
            if envConfig == EnvironmentCase.sandbox.rawValue || envConfig == EnvironmentCase.mock.rawValue {
                requestLogger.log(request: request, route: route)
            }
            
            executor.perform(request) { [weak self] (data, response, error) in
                if self?.envConfig == EnvironmentCase.sandbox.rawValue || self?.envConfig == EnvironmentCase.mock.rawValue {
                    requestLogger.log(response, request, data, nil)
                }
                
                completion(data, response, error)
            }
        } catch {
            if envConfig == EnvironmentCase.sandbox.rawValue || envConfig == EnvironmentCase.mock.rawValue {
                requestLogger.log(nil, nil, nil, error)
            }
            
            completion(nil, nil, error)
        }
    }
    
//    public func download(_ route: ApiBuilder, completion: @escaping NetworkRouterCompletion) {
//        let url = buildURL(from:route)
//        let pdfData = try? Data.init(contentsOf: url)
//        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
//        let pdfNameFromUrl = "VFNetwork-test.pdf"
//        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
//        do {
//            try pdfData?.write(to: actualPath, options: .atomic)
//            print("pdf successfully saved on \(actualPath.absoluteString)")
//            completion(pdfData, nil, nil)
//        } catch {
//            completion(nil, nil, error)
//            print("Pdf could not be saved")
//        }
//    }
    
    /**
        Method for creating a request before it is executed.
    
    - Parameters:
       - route: ApiBuilder
       - responseType: Element.Type
    - Returns:
        (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
     
     */
    fileprivate func buildRequest(from route: ApiBuilder) throws -> URLRequest {
        var request = URLRequest(url: buildURL(from: route),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        setHeaders(to: &request, from: route)
        
        do {
            switch route.task {
            case .request:
                addAdditionalHeaders(RequestHeader().default(.json), request: &request)
            case .requestEncoder(let codable):
                try self.configureCodable(codable.dictionary(), request: &request)
            case .requestBody(let bodyParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: nil, request: &request)
            case .requestURLParameters(let urlParameters):
                try self.configureParameters(bodyParameters: nil, urlParameters: urlParameters, request: &request)
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    /**
        Method that creates request URL before it is executed.
    
    - Parameters:
       - route: ApiBuilder
     
    - Returns:
        URL
     
     */
    fileprivate func buildURL(from route: APIBuilder) -> URL {
        switch route.path {
        case .plain(let path):
            return route.baseURL.appendingPathComponent(path)
        case .composed(let path, let pathId):
            if path.last == "/" {
                return route.baseURL.appendingPathComponent(path + pathId)
            } else {
                return route.baseURL.appendingPathComponent("\(path)/\(pathId)")
            }
        }
    }
    
    /**
        Method that configure a codable body object.
    
    - Parameters:
       - dictionary: [String: Any]?
       - request: inout URLRequest
     
    - Returns:
        throws
     
     */
    fileprivate func configureCodable(_ dictionary: [String: Any]?, request: inout URLRequest) throws {
        do {
            if let jsonParameters = dictionary {
                try JSONParameterEncoding.encode(urlRequest: &request, with: jsonParameters)
            }
        }
    }
    
    /**
        Method that sets a parameter based on the choice of task in APIBuilder.
    
    - Parameters:
       - dictionary: [String: Any]?
       - request: inout URLRequest
     
    - Returns:
        throws
     
     */
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoding.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoding.encode(urlRequest: &request, with: urlParameters)
            }
        }
    }
    
    /**
        Method that sets a headers based on the choice of header in APIBuilder.
    
    - Parameters:
       - additionalHeaders: [String: String]?
       - request: inout URLRequest
     
    - Returns:
        Void
     
     */
    fileprivate func addAdditionalHeaders(_ additionalHeaders: [String: String]?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func setHeaders(to request: inout URLRequest, from route: ApiBuilder) {
        for (key, value) in route.headers.values {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    /**
     Checks for any errors based on the response.
     
     - Parameters:
        - response: URLResponse
        - error: Error
     - Returns:
        - Throw
     
     */
    func verifyData(_ response: URLResponse?, _ error: Error?) throws {
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 400:
                throw APIError.badRequest(error)
            case 401:
                VFSubject.shared.publish(.update)
                throw APIError.unauthorized(error)
            case 403:
                throw APIError.forbidden(error)
            case 404:
                throw APIError.notFound(error)
            case 500:
                throw APIError.internalError(error)
            default:
                throw APIError.unknown(error)
            }
        }
    }
}
