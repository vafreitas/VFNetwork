//
//  RequestLogger.swift
//  VFNetwork
//
//  Created by Victor Alves De Freitas on 30/06/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

/**
  For log some things of request and response.
 */
class RequestLogger<ApiBuilder: APIBuilder> {
    static func log(request: URLRequest, route: ApiBuilder) {
        print("\n - - - - - - - - - - REQUEST - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END REQUEST - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
//        let cacheable = route.cacheable ? "✅" : "❌"
//        💾 CACHED: \(cacheable) \n
        
        var logOutput = """
         🌎 HOST: \(host)\n
         🎯 URL: \(urlAsString)\n
         🚀 \(method) \(path)?\(query) HTTP/1.1 \n
         🛡 HEADERS: \n
        """
        
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "       \(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n  📨 BODY: \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        print(logOutput)
    }
    
    static func log(_ response: URLResponse?, _ request: URLRequest?, _ data: Data?, _ error: Error?) {
        print("\n - - - - - - - - - - RESPONSE - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END RESPONSE - - - - - - - - - - \n") }
        
        if let httpResponse = response as? HTTPURLResponse, let request = request {
            let statusCode = "\(httpResponse.statusCode)"
            let urlAsString = request.url?.absoluteString ?? ""
            let urlComponents = NSURLComponents(string: urlAsString)
            let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
            let path = "\(urlComponents?.path ?? "")"
            let query = "\(urlComponents?.query ?? "")"
            var responseBody: Any?
            
            if let data = data {
                do {
                    responseBody = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                } catch let error {
                    print(error)
                }
            }
            
            var statusCodeText = ""
            switch httpResponse.statusCode {
            case 200...299:
                statusCodeText = " ✅ STATUS CODE: \(statusCode)"
            case 400...500:
                statusCodeText = " ❌ STATUS CODE: \(statusCode)"
            default:
                break
            }

            var logOutput = """
            \(statusCodeText) \n
             🚀 \(method) \(path)?\(query) HTTP/1.1 \n
             🛡 HEADERS: \n
            """
            
            for (key, value) in httpResponse.allHeaderFields {
                logOutput += "       \(key): \(value) \n"
            }
            
            logOutput += "  📨 BODY: \(responseBody ?? "")\n"
            print(logOutput)
        } else {
            let logOutput = """
            ERROR: \(error?.localizedDescription ?? "")
            """
            print(logOutput)
        }
    }
}
