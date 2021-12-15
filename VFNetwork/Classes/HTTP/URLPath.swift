//
//  HTTPPath.swift
//  inWave Back Office
//
//  Created by Victor Alves De Freitas on 07/07/19.
//  Copyright © 2019 brvlab. All rights reserved.
//

import Foundation

public enum URLPath {
    case plain(_ path: String)
    case composed(_ path: String, pathId: String)
}
