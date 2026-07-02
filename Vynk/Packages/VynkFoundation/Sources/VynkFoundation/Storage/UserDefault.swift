//
//  UserDefault.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//

import Foundation

@propertyWrapper
public struct UserDefault<Value> {

    private let key: String
    private let defaultValue: Value
    private let store: UserDefaults

    public init(
        key: String,
        defaultValue: Value,
        store: UserDefaults = .standard
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }

    public var wrappedValue: Value {
        get {
            store.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            store.set(newValue, forKey: key)
        }
    }
}
