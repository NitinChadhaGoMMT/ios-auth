//
//  CommonAnalytisProtocol.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 26/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

public protocol CommonAnalytisProtocol {
    
    static func logCategory(event: String, dictionary: Dictionary<String, Any>?)
    
    static func pushEvent(withName name: String, withAttributes attributes: [AnyHashable: Any]?)
    
}

