//
//  KeyChainLoginProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 07/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol KeyChainLoginViewToPresenterProtocol: class {
    
    var dataSource: Array<Any> { get }
}
