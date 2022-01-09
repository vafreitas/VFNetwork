//
//  Cacheable.swift
//  IamChuck
//
//  Created by Victor Freitas on 28/10/19.
//  Copyright © 2019 Victor Freitas. All rights reserved.
//

import Foundation

public typealias Cacheable = CacheableObject & VCodable

/**
 Protocol for cacheable objects
 */
public protocol CacheableObject {
    static var cacheKey: String { get }
}
