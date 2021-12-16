//
//  HomeViewModel.swift
//  VFNetwork_Example
//
//  Created by Victor Freitas on 15/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VFNetwork

class HomeViewModel {
    
    // MARK: Properties
    
    let model: HomeModel
    let service = HomeService()
    
    // MARK: Initializer
    
    init(model: HomeModel = .init()) {
        self.model = model
    }
    
    func getJokes(completion: @escaping (Result<HomeModel, Error>) -> Void) {
        service.getJokes { result in
            switch result {
            case let .success(.load(joke)):
                completion(.success(joke))
            case let .success(.cache(joke)):
                completion(.success(joke))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getCategories() {
        service.getCategories { result in
            switch result {
            case let .success(.load(categories)):
                break
            case let .success(.cache(categories)):
                print(categories)
                break
            case let .failure(error):
                print(error)
            }
        }
    }
}
