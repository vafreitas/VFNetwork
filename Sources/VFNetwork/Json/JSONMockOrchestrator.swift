//
//  JSONMockOrchestrator.swift
//  VFNetwork
//
//  Created by Victor Freitas on 16/12/21.
//

import Foundation

open class JSONMockOrchestrator: RequestOrchestratorProtocol {
    
    // MARK: Properties
    
    private var bundle: Bundle
    private var jsonContentFile: [String: JSONMockContentFile] = [:]
    private var fileNamed: String
    
    // MARK: Initializers
    
    public init() {
        bundle = Bundle.main
        fileNamed = ""
    }
    
    // MARK: Register Method
    
    public func register(fileNamed: String, statusCode: Int = 200){
        let contentFile = JSONMockContentFile(fileNamed: fileNamed, statusCode: statusCode)
        self.fileNamed = fileNamed
        
        jsonContentFile[fileNamed] = contentFile
    }
    
    private func getDataFromJson(fileNamed: String) -> Data? {
        if let url = bundle.url(forResource: fileNamed, withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                print("Error!! Unable to parse  \(fileNamed).json")
            }
        }
        return nil
    }
    
    // MARK: Protocol Method
    
    public func execute(request: URLRequest, in session: URLSession, completion: @escaping (Data?, URLResponse?, APIError?) -> Void) {
        
        guard let contentFile = jsonContentFile[self.fileNamed] else {
            let error = getApiError(request.url?.path)
            completion(nil, nil, error)
            return
        }
        
        let httpResponse = HTTPURLResponse(
            url: request.url!,
            statusCode: contentFile.statusCode,
            httpVersion: nil,
            headerFields: nil
        )
        
        guard let contentData = getDataFromJson(fileNamed: contentFile.fileNamed) else {
            let error = getApiError(request.url?.path)
            completion(nil, httpResponse, error)
            return
        }
        
        completion(contentData, httpResponse, nil)
    }
    
    private func getApiError(_ path: String?) -> APIError {
        let message = "Response not found for path: \"\(path ?? "/")\""
        let userInfo = [NSLocalizedDescriptionKey: message]
        let e = NSError(domain: "", code: 4, userInfo: userInfo)
        return APIError.unknown(e)
    }
}
