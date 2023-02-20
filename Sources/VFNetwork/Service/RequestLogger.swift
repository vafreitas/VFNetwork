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
        var requestBody: String? = ""
        logger.clear()
        
        if let data = request.httpBody {
            requestBody = genJsonString(with: data)
        }
        
        logger.log(
            .inline(key: "[REQUEST-ID] -", value: uuid),
            .breakLine,
            .inline(icon: .host, key: "Host:", value: host),
            .inline(icon: .url, key: "Url:", value: "\(method) | \(urlAsString)"),
            .inline(icon: .request, key: "Path:", value: "\(path)?\(query) HTTP"),
            .multline(icon: .secure, title: "Headers:", values: request.allHTTPHeaderFields ?? [:]),
            .breakLine,
            .vIf(requestBody != "", {[
                .inline(icon: .body, key: "Body:", value: requestBody ?? "")
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
            let responseHeaders = (response as? HTTPURLResponse)?.allHeaderFields
            let query = "\(urlComponents?.query ?? "")"
            var responseBody: String?
            
            if let data = data {
                responseBody = genJsonString(with: data)
            }
            
            logger.log(
                .inline(key: "[RESPONSE-ID] -", value: lastUUID),
                .breakLine,
                .inline(icon: httpResponse.statusCode < 299 ? .success : .failure, key: "Status Code: ", value: statusCode),
                .inline(icon: .url, key: "Url:", value: "\(method) | \(urlAsString)"),
                .inline(icon: .request, key: "Path:", value: "\(path)?\(query) HTTP"),
                .multline(icon: .secure, title: "Headers:", values: responseHeaders ?? [:]),
                .breakLine,
                .inline(icon: .body, key: "Body:", value: "\n\n\(responseBody ?? "")"),
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
    
    // MARK: Auxiliar Functions
    
    func genJsonString(with data: Data) -> String? {
        do {
            let json = try JSONSerialization.jsonObject(with: data)
            var options: JSONSerialization.WritingOptions = [.prettyPrinted]
            if #available(iOS 13.0, *) {
                options = [.prettyPrinted, .withoutEscapingSlashes]
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: options)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch let error {
            print(error)
            return nil
        }
    }
}

extension String {
    func pretty() -> String {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let pretty = try encoder.encode(self.self)
            return String(data: pretty, encoding: .utf8) ?? ""
        } catch {
            debugPrint(error)
        }
        
        return ""
    }
}
