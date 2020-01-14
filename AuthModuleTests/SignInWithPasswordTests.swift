//
//  SignInWithPasswordTests.swift
//  AuthModuleTests
//
//  Created by Nitin Chadha on 14/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import XCTest
@testable import AuthModule

class SignInWithPasswordPresenterTests: XCTestCase {

    var presenter: SignInWithPasswordPresenter!
    
    override func setUp() {
        presenter = SignInWithPasswordPresenter(mobileNumber: "7838387938", state: .passwordOTP, data: PresenterCommonData())
    }
    
    func testConfigureDataSource() {
        XCTAssertEqual(presenter.dataSource.count, 5, "Cells count is not correct")
    }
    
}
