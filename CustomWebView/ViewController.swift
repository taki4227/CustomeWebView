//
//  ViewController.swift
//  CustomWebView
//
//  Created by 滝本直樹 on 2018/10/26.
//  Copyright © 2018年 taki. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    // MARK: - Properties
    
    private var didSetupConstraints = false
    
    // MARK: - View
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - ViewController lifecycle
    
    override func loadView() {
        view = BaseView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://google.co.jp")
        let request = NSURLRequest(url: url!)
        
        webView.load(request as URLRequest)
        
        view.addSubview(webView)
    }
    
    override func updateViewConstraints() {
        
        if (!didSetupConstraints) {
            
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
                webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0),
                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0)
            ])
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}
