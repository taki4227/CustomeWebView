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
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - ViewController lifecycle
    
    override func loadView() {
        view = BaseView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://google.co.jp")
        let request = URLRequest(url: url!)
        
        webView.load(request)

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

// MARK: - WKNavigationDelegate

extension ViewController: WKNavigationDelegate {
    /// 認証に応答する必要があるときに呼ばれる
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        let credential = URLCredential(user: "", password: "", persistence: URLCredential.Persistence.forSession)
//        completionHandler(.useCredential, credential)
        
        guard let host = webView.url?.host else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        let alert = UIAlertController(title: host + "にログイン", message: "ユーザ名とパスワードを入力してください。", preferredStyle: .alert)
        
        // ユーザ名のテキストフィールドを追加
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "ユーザ名"
            textField.tag = 1
        })
        
        // パスワードのテキストフィールドを追加
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "パスワード"
            textField.isSecureTextEntry = true
            textField.tag = 2
        })
        
        // ログインボタンの設定
        let okAction = UIAlertAction(title: "ログイン", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            var user = ""
            var password = ""
            
            if let textFields = alert.textFields {
                for textField in textFields {
                    if textField.tag == 1 {
                        user = textField.text ?? ""
                    } else if textField.tag == 2 {
                        password = textField.text ?? ""
                    }
                }
            }
            
            print(user)
            print(password)
            
            let credential = URLCredential(user: user, password: password, persistence: URLCredential.Persistence.forSession)
            completionHandler(.useCredential, credential)
        })
        alert.addAction(okAction)
        
        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action:UIAlertAction!) -> Void in
            completionHandler(.cancelAuthenticationChallenge, nil)
        })
        alert.addAction(cancelAction)
        
        // アラートを画面に表示
        present(alert, animated: true, completion: nil)
    }
}
