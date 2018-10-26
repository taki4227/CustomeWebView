//
//  ViewController.swift
//  CustomWebView
//
//  Created by 滝本直樹 on 2018/10/26.
//  Copyright © 2018年 taki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    
    private var didSetupConstraints = false
    
    // MARK: - View
    
    private lazy var helloWorldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Hello World!"
        
        return label
    }()
    
    // MARK: - ViewController lifecycle
    
    override func loadView() {
        view = BaseView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(helloWorldLabel)
    }
    
    override func updateViewConstraints() {
        
        if (!didSetupConstraints) {
            
            NSLayoutConstraint.activate([
                helloWorldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                helloWorldLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }

}

