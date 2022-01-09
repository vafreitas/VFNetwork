//
//  APIBuilder.swift
//  inWave Back Office
//
//  Created by Victor Alves De Freitas on 26/06/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

public protocol APIBuilder {
    var path: URLPath { get }
    var httpMethod: HTTPMethods { get }
    var headers: HTTPHeader { get }
    var task: HTTPTask { get }
//    var cacheable: Bool { get }
}

