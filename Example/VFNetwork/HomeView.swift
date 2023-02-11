//
//  HomeView.swift
//  VFNetwork_Example
//
//  Created by Victor Freitas on 15/12/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    let testButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Test API", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    let statusInfoView: UIView = {
        let view = UIView()
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        
        let infoTitleLabel = UILabel()
        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        infoTitleLabel.text = "Status"
        
        let infoSubtitleLabel = UILabel()
        infoSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoSubtitleLabel.font = UIFont.systemFont(ofSize: 14)
        infoSubtitleLabel.text = "Online"
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        view.layer.cornerRadius = 4
        
        labelStackView.addArrangedSubview(infoTitleLabel)
        labelStackView.addArrangedSubview(infoSubtitleLabel)
        
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(UIView())
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(testButton)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        
        testButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100).isActive = true
        testButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        statusInfoView.translatesAutoresizingMaskIntoConstraints = false
//
//        let guide = self.safeAreaLayoutGuide
//        statusInfoView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20).isActive = true
//        statusInfoView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16).isActive = true
    }
}
