//
//  UserDefault.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {

    let key: String
    let defaultValue: Value

    var wrappedValue: Value {
        get {
            UserDefaults.standard.object(
                forKey: key
            ) as? Value ?? defaultValue
        }
        set {
            UserDefaults.standard.set(
                newValue,
                forKey: key
            )
        }
    }
}
