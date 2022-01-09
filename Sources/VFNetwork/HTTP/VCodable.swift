//
//  ICodable.swift
//  i`mChuck
//
//  Created by Victor Freitas on 19/10/19.
//  Copyright © 2019 Victor Freitas. All rights reserved.
//

import Foundation

/**
Protocol  for Codable typealias

- Note:
       This protocol is for implement some convertion methods and diferent initializers
*/
public protocol VCodable: Codable {}

extension VCodable {
    init?(_ dictionary: [String: Any]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let object = try JSONDecoder().decode(Self.self, from: data)
            self = object
        } catch {
            return nil
        }
    }
    
    init?(_ data: Data) {
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(Self.self, from: data)
            self = object
        } catch let error {
            print("\n❓JSONDecoder -> \(Self.self): \(error)\n")
            return nil
        }
    }
    
    func dictionary() -> [String: Any]? {
        if let jsonData = try? JSONEncoder().encode(self),
            let dict = ((try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]) as [String : Any]??) {
            return dict
        }
        return nil
    }
    
    func jsonString() -> String {
        if  let data = try? JSONEncoder().encode(self),
            let str = String(data: data, encoding: .utf8) {
            return str
        }
        return "{}"
    }
}
