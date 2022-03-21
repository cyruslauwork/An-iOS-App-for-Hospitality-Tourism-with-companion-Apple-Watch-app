//
//  Defaults.swift
//  Weather
//
//  Created by Brian Advent on 14.12.19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

final class SettingsStore: ObservableObject {

    let objectWillChange = PassthroughSubject<Void, Never>()

    @UserDefault("Celsius", defaultValue: false)
    var showCelsius: Bool {
        willSet {
            objectWillChange.send()
        }
    }
}
