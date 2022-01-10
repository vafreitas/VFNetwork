//
//  HomeService.swift
//  VFNetwork_Example
//
//  Created by Victor Freitas on 15/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import VFNetwork

class HomeService: RequestService<HomeAPI> {
    func getJokes(completion: @escaping (Result<HomeModel, Error>) -> Void) {
        execute(.home, responseType: HomeModel.self, completion: completion)
    }
    
    func getCategories(completion: @escaping (Result<HomeCategories, Error>) -> Void) {
        execute(.categories, responseType: HomeCategories.self, completion: completion)
    }
}
