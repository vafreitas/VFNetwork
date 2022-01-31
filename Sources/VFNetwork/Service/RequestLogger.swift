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
    var logger = VLogger()
    var lastUUID = ""
    
    func log(request: URLRequest, route: ApiBuilder) {
        let uuid = UUID().uuidString
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        let body = (NSString(data: request.httpBody ?? Data(), encoding: String.Encoding.utf8.rawValue) ?? "")
        logger.clear()
        
        logger.log(
            .inline(key: "[REQUEST-ID] -", value: uuid),
            .breakLine,
            .inline(icon: .host, key: "Host:", value: host),
            .inline(icon: .url, key: "Url:", value: "[\(method)] \(urlAsString)"),
            .inline(icon: .request, key: "Path:", value: "\(path)?\(query) HTTP"),
            .multline(icon: .secure, title: "Headers:", values: request.allHTTPHeaderFields ?? [:]),
            .breakLine,
            .vIf(body != "", {[
                .inline(icon: .body, key: "Body:", value: String(body))
            ]}, vElse: {[
                .inline(icon: .body, key: "Body: ", value: "Empty")
            ]}),
            .breakLine,
            .inline(key: "[END REQUEST] -", value: uuid),
            .breakLine
        )
        
        lastUUID = uuid
    }
    
    func log(_ response: URLResponse?, _ request: URLRequest?, _ data: Data?, _ error: Error?) {
        logger.clear()
        
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
            
            logger.log(
                .inline(key: "[RESPONSE-ID] -", value: lastUUID),
                .breakLine,
                .inline(icon: httpResponse.statusCode < 299 ? .success : .failure, key: "Status Code: ", value: statusCode),
                .inline(icon: .url, key: "Url:", value: "[\(method)] \(urlAsString)"),
                .inline(icon: .request, key: "Path:", value: "\(path)?\(query) HTTP"),
                .multline(icon: .secure, title: "Headers:", values: request.allHTTPHeaderFields ?? [:]),
                .breakLine,
                .inline(icon: .body, key: "Body:", value: "\(responseBody ?? "")"),
                .breakLine,
                .inline(key: "[END RESPONSE] -", value: lastUUID),
                .breakLine
            )

        } else {
            logger.log(
                .inline(key: "[RESPONSE-ID] -", value: lastUUID),
                .breakLine,
                .inline(icon: .failure, key: "Error:", value: error?.localizedDescription ?? ""),
                .breakLine,
                .inline(key: "[END RESPONSE] -", value: lastUUID),
                .breakLine
            )
        }
    }
}
