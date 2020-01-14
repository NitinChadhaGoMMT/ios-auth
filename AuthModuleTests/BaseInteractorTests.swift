//
//  BaseInteractorTests.swift
//  AuthModuleTests
//
//  Created by Nitin Chadha on 14/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import XCTest
@testable import AuthModule

class BaseInteractorTests: XCTestCase, InteractorBaseProtocol {
    
    override func setUp() {
        
    }
    
    func checkForMobileConnectAPI(completionBlock: @escaping (MconnectData?) -> ()) { }
    
    func verifymConnectDataWithMobileNo(_ mobileNo: String) { }
}
