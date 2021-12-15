//
//  Disk.swift
//  IamChuck
//
//  Created by Victor Freitas on 28/10/19.
//  Copyright © 2019 Victor Freitas. All rights reserved.
//

import Foundation

struct Disk {
    var name: String
    var directory: URL
    
    init(name: String, directory: URL) {
        self.name = name
        self.directory = directory
    }
}
