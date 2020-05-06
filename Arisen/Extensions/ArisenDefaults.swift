//
//  ArisenDefaults.swift
//  ArisenReferenceAuthenticator
//
//  Created by Steve McCoole on 10/3/18.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation

public protocol ArisenDefaultable {
    associatedtype ArisenDefaultKey: RawRepresentable
}

public extension ArisenDefaultable where ArisenDefaultKey.RawValue == String {
        
    static func set(_ bool: Bool, forKey key: ArisenDefaultKey) {
        UserDefaults.standard.set(bool, forKey: key.rawValue)
    }
    
    static func bool(forKey key: ArisenDefaultKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    static func bool(forKey key: ArisenDefaultKey, defaultValue: Bool) -> Bool {
        if (UserDefaults.standard.value(forKey: key.rawValue) == nil) {
            UserDefaults.standard.set(defaultValue, forKey: key.rawValue)
        }
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
}

public extension UserDefaults {
    struct Arisen: ArisenDefaultable {
        private init() { }
        
        public enum ArisenDefaultKey: String {
            case copyPublicKey = "COPY_PUBLIC_KEY"
            case disableDeleteKeysAbility = "DISABLE_DELETE_SOFT_KEYS"
            case autorizersHelperTextHasBeenShown = "AUTHORIZERS_TUTORIAL_SHOWN"
            case insecureMode = "INSECURE_MODE"
        }

    }
    
}
