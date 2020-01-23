//
//  Dictionary_Extensions.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

extension Dictionary {
    func merge(_ dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        
        var mutableCopy = self
        
        for (key, value) in dict {
            mutableCopy[key] = value
        }
        
        return mutableCopy
    }
}
