//
//  UserDefaults.swift
//  CustomWebView
//
//  Created by 滝本直樹 on 2018/11/02.
//  Copyright © 2018年 taki. All rights reserved.
//

import UIKit

protocol UserDefaultsKey {
//    associatedtype ValueType: Any
    var bundleIdentifier: String { get }
    var keyName: String { get }
//    var defaultValue: ValueType { get }
}

extension UserDefaultsKey {
    var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier!
    }
}

enum AppConfigKey: String, UserDefaultsKey, CaseIterable {
    case userName
    
    var keyName: String {
        let className = String(describing: type(of: self))
        return "\(bundleIdentifier).\(className).\(rawValue)"
    }
    
//    var defaultValue: Any {
//        switch self {
//        case .userName:
//            return "test1"
//        }
//    }
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
    
//    func get<T: Any>(key: UserDefaultsKey, defaultValue: T) -> T {
//        return (object(forKey: key.keyName) as? T) ?? defaultValue
//    }
    
    func get<T: Any>(key: UserDefaultsKey) -> T? {
        return object(forKey: key.keyName) as? T
    }
    
    func set(key: UserDefaultsKey, value: Any?) {
        set(value, forKey: key.keyName)
    }
    
    func remove(key: UserDefaultsKey) {
        removeObject(forKey: key.keyName)
    }
    
    func removeAll<T: UserDefaultsKey & CaseIterable>(config: T) {
        T.allCases.forEach { key in
            removeObject(forKey: key.keyName)
        }
    }
    
    func printAll<T: UserDefaultsKey & CaseIterable>(config: T) {
        T.allCases.forEach { key in
            let value = get(key: key, defaultValue: "nil")
            print("\(key): \(value)")
        }
    }
}
