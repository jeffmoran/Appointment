//
//  UserDefault.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/29/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

@propertyWrapper struct UserDefault<T: RawRepresentable> {
    private let key: String
    private let defaultValue: T

    var wrappedValue: T {
        get {
            guard let rawValue = UserDefaults.standard.object(forKey: key) as? T.RawValue else {
                return defaultValue
            }

            return T(rawValue: rawValue) ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
    }

     init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
