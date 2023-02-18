//
//  ViewController.swift
//  VFNetwork
//
//  Created by tqi-valves on 12/15/2021.
//  Copyright (c) 2021 tqi-valves. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Properties
    
    let viewModel: HomeViewModel
    let rootView = HomeView()
    
    // MARK: Initializer
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VFNetwork"
        
        rootView.testButton.addTarget(self, action: #selector(testApi), for: .touchUpInside)
    }
    
    @objc func testApi() {
        viewModel.getJokes { result in
            switch result {
            case let .success(jokes):
                break
            case let .failure(error):
                debugPrint(error)
            }
        }
        
        viewModel.getCategories()
        
        viewModel.service.group.notify(queue: .main) {
            print("Services Finished.")
        }
    }
}

