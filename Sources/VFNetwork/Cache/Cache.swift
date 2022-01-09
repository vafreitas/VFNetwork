//
//  CacheFactory.swift
//  IamChuck
//
//  Created by Victor Freitas on 28/10/19.
//  Copyright © 2019 Victor Freitas. All rights reserved.
//

import Foundation

private struct CacheFactoryKeys {
    static let diskName = "DerivedData"
    static let directoryPath = "Preferences"
}

private enum CacheFactoryError: Error {
    case buildError
}

/**
 Class for networking cache system
 */
class Cache<T: Cacheable> {
    
    // MARK: Properties
    
    private var documentPath: URL?
    private var diskConfig: Disk
    
    // MARK: Initializer
    
    init() {
        documentPath = try? FileManager.default.url(for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true)
        
        let folder = documentPath ?? URL(fileURLWithPath: NSTemporaryDirectory())
        let path = "\(CacheFactoryKeys.directoryPath)\(T.cacheKey)"
        let directory = folder.appendingPathComponent(path)
        
        diskConfig = Disk(name: CacheFactoryKeys.diskName, directory: directory)
    }
    
    // MARK: Cache Manager Methods
    
    /**
     Create a new file on disk base in DiskConfig
        
        - Parameters:
            - file: Generic object
     
        - Returns:
               T: Generic object
     */
    func create(_ file: T) throws -> T {
        do {
            let data = try JSONEncoder().encode(file)
            try data.write(to: diskConfig.directory)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CacheFactoryError.buildError
        }
    }
    
    /**
    get file on disk base in DiskConfig
       
       - Returns:
              T?: (Optional) Generic object
    */
    func get() throws -> T? {
        do {
            let data = try Data(contentsOf: diskConfig.directory)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CacheFactoryError.buildError
        }
    }
    
    /**
    Remove file from disk base in DiskConfig
       
       - Returns:
              T?: (Optional) Generic object
    */
    func clear() throws {
        do {
            try FileManager.default.removeItem(at: diskConfig.directory)
        } catch {
            throw CacheFactoryError.buildError
        }
    }
}
