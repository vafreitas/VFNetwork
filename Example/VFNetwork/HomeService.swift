//
//  HomeService.swift
//  VFNetwork_Example
//
//  Created by Victor Freitas on 15/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import VFNetwork
import Foundation

class HomeService: RequestService<HomeAPI> {
    
    let group = DispatchGroup()
    
    func getJokes(completion: @escaping (Result<HomeModel, Error>, _ group: DispatchGroup) -> Void) {
        execute(.home, responseType: HomeModel.self, group: group, completion: completion)
    }
    
    func getCategories(completion: @escaping (Result<HomeCategories, Error>, _ group: DispatchGroup) -> Void) {
        execute(.categories, responseType: HomeCategories.self, group: group, completion: completion)
    }
}
