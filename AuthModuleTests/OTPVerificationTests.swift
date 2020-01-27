//
//  OTPVerificationTests.swift
//  AuthModuleTests
//
//  Created by Nitin Chadha on 27/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import XCTest
@testable import AuthModule

class OTPVerificationTests: XCTestCase {

    var presenter = OTPVerificationPresenter(mobileNumber: "7838387938", nonce: nil, isNewUser: false, data: PresenterCommonData())
    
    func testShouldShowWhatsappLogin() {
        XCTAssertTrue(presenter.shouldShowWhatsappLogin(), "Whatsapp should not be enabled ")
    }
    
}
