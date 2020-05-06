//
//  ArisenTransactionActionRicardian.swift
//
//  Created by Todd Bowden on 4/18/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation
import ArisenSwift

extension ArisenTransaction.Action {
    
    private static var ricardians = NSMapTable<ArisenTransaction.Action, Ricardian>(keyOptions: [NSMapTableWeakMemory,NSMapTableObjectPointerPersonality], valueOptions: [NSMapTableStrongMemory])
    
    var ricardian: Ricardian? {
        get {
            return ArisenTransaction.Action.ricardians.object(forKey: self)
        }
        set {
            ArisenTransaction.Action.ricardians.setObject(newValue, forKey: self)
        }
    }
    
    /// Ricardian struct for `ArisenTransaction.Action`
    class Ricardian {
        /// Rendered ricardian contract in html format
        public var html = ""
        /// Ricardian metadata (title, summary and icon)
        public var metadata = Metadata()
        /// Error rendering the ricardian contract
        public var error = ""
        
        /// Ricardian metadata (title, summary and icon)
        public struct Metadata {
            /// Action title
            public var title = ""
            /// Action summary
            public var summary = ""
            /// Action icon url
            public var icon = ""
        }
    }
    
}
