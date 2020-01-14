//
//  AuthUtilsTests.swift
//  AuthModuleTests
//
//  Created by Nitin Chadha on 14/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import XCTest
@testable import AuthModule

class AuthUtilsTests: XCTestCase {

    func testIsValidPhoneNumber() {
        XCTAssertFalse(AuthUtils.isValidPhoneNumber(nil))
        XCTAssertFalse(AuthUtils.isValidPhoneNumber(""))
        XCTAssertFalse(AuthUtils.isValidPhoneNumber(" "))
        XCTAssertFalse(AuthUtils.isValidPhoneNumber("    "))
        XCTAssertFalse(AuthUtils.isValidPhoneNumber("1"))
        XCTAssertFalse(AuthUtils.isValidPhoneNumber("781838488343"))
        XCTAssertTrue(AuthUtils.isValidPhoneNumber("7838387938"))
        XCTAssertTrue(AuthUtils.isValidPhoneNumber("7838387931"))
        XCTAssertFalse(AuthUtils.isValidPhoneNumber("----------"))
        XCTAssertFalse(AuthUtils.isValidPhoneNumber("1234567890"))
    }
    
    func testIsValidName() {
        XCTAssertFalse(AuthUtils.isValidName(nil))
        XCTAssertFalse(AuthUtils.isValidName(""))
        XCTAssertFalse(AuthUtils.isValidName(" "))
        XCTAssertFalse(AuthUtils.isValidName("    "))
        XCTAssertFalse(AuthUtils.isValidName("1"))
        XCTAssertFalse(AuthUtils.isValidName("123"))
        XCTAssertTrue(AuthUtils.isValidName("A"))
        XCTAssertTrue(AuthUtils.isValidName("aBbCxZy"))
        XCTAssertFalse(AuthUtils.isValidName("--aBbCxZy.-"))
        XCTAssertFalse(AuthUtils.isValidName("ads123"))
    }
    
    func testIsEmptyString() {
        XCTAssertTrue(AuthUtils.isEmptyString(nil))
        XCTAssertTrue(AuthUtils.isEmptyString(""))
        XCTAssertTrue(AuthUtils.isEmptyString(" "))
        XCTAssertTrue(AuthUtils.isEmptyString("   "))
        XCTAssertFalse(AuthUtils.isEmptyString("a"))
        XCTAssertFalse(AuthUtils.isEmptyString("a2"))
        XCTAssertFalse(AuthUtils.isEmptyString("313413"))
    }
    
}
