//
//  APIBuilder+BaseURL.swift
//  VFNetwork
//
//  Created by Victor Alves De Freitas on 01/07/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

extension APIBuilder {
    var baseURL: URL {
        guard let url = URL(string: Environment().configuration(.baseURL)) else { fatalError("BaseURL is nil") }
        return url
    }
}
