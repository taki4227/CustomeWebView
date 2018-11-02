//
//  UserDefaults.swift
//  CustomWebView
//
//  Created by 滝本直樹 on 2018/11/02.
//  Copyright © 2018年 taki. All rights reserved.
//

import UIKit

protocol UserDefaultsKey {
    var bundleIdentifier: String { get }
    var keyName: String { get }
}

extension UserDefaultsKey {
    var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier!
    }
}

enum AppConfig1: String, UserDefaultsKey, CaseIterable {
    case userName
    case tel
    
    var keyName: String {
        let className = String(describing: type(of: self))
        return "\(bundleIdentifier).\(className).\(rawValue)"
    }
}

enum AppConfig2: String, UserDefaultsKey, CaseIterable {
    case userName
    
    var keyName: String {
        let className = String(describing: type(of: self))
        return "\(bundleIdentifier).\(className).\(rawValue)"
    }
}

extension UserDefaults {
    func register(key: UserDefaultsKey, value: Any) {
        register(defaults: [key.keyName: value])
    }
    
    func present(key: UserDefaultsKey) -> Bool {
        return object(forKey: key.keyName) != nil
    }
    
    func blank(key: UserDefaultsKey) -> Bool {
        return !present(key: key)
    }
    
    func get<T: Any>(key: UserDefaultsKey, defaultValue: T) -> T {
        return (object(forKey: key.keyName) as? T) ?? defaultValue
    }
    
    func get<T: Any>(key: UserDefaultsKey) -> T? {
        return object(forKey: key.keyName) as? T
    }
    
    func set(key: UserDefaultsKey, value: Any?) {
        set(value, forKey: key.keyName)
    }
    
    func remove(key: UserDefaultsKey) {
        removeObject(forKey: key.keyName)
    }
    
    func removeAll<T: UserDefaultsKey & CaseIterable>(config: T.Type) {
        T.allCases.forEach { key in
            remove(key: key)
        }
    }
    
    func printAll<T: UserDefaultsKey & CaseIterable>(config: T.Type) {
        T.allCases.forEach { key in
            let value = get(key: key, defaultValue: "nil")
            print("\(key): \(value)")
        }
    }
}
