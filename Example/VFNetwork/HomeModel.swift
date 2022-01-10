//
//  HomeModel.swift
//  VFNetwork_Example
//
//  Created by Victor Freitas on 15/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VFNetwork

struct HomeModel: VCodable {
    var icon_url: String = ""
    var id: String = ""
    var url: String = ""
    var value: String = ""
}

struct HomeCategories: VCodable {
    var categories: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        categories = try container.decode([String].self)
    }
    
    func encode(to encoder: Encoder) throws {
         var container = encoder.singleValueContainer()
         try container.encode(categories)
     }
}
