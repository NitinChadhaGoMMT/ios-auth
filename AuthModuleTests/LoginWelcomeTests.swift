//
//  LoginWelcomeTests.swift
//  AuthModuleTests
//
//  Created by Nitin Chadha on 14/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import XCTest
@testable import AuthModule

internal let referCode: String = "DHIN786"
internal let branchMockDictionary: NSDictionary = ["refercode": referCode, "fname":"Nitin"]

class LoginWelcomePresenterTests: XCTestCase {
    
    var presenter: LoginWelcomePresenter!
    var expectation: XCTestExpectation!
    var mockInteractor:LoginWelcomeInteractorTests!
    
    override func setUp() {
        presenter = LoginWelcomePresenter()
        mockInteractor = LoginWelcomeInteractorTests()
        mockInteractor.presenter = self
    }
    
    func testIsValidPhoneNumber() {
        XCTAssertFalse(presenter.isValidPhoneNumber(mobileNumber: nil), "Invalid Mobile Number")
        XCTAssertFalse(presenter.isValidPhoneNumber(mobileNumber: ""), "Invalid Mobile Number")
        XCTAssertFalse(presenter.isValidPhoneNumber(mobileNumber: "   "), "Invalid Mobile Number")
        XCTAssertFalse(presenter.isValidPhoneNumber(mobileNumber: "1234"), "Invalid Mobile Number")
        XCTAssertFalse(presenter.isValidPhoneNumber(mobileNumber: "123456789"), "Invalid Mobile Number")
        XCTAssertFalse(presenter.isValidPhoneNumber(mobileNumber: "11111"), "Invalid Mobile Number")
        XCTAssertTrue(presenter.isValidPhoneNumber(mobileNumber: "7838387938"), "Invalid Mobile Number")
        XCTAssertFalse(presenter.isValidPhoneNumber(mobileNumber: "1111111111"), "Invalid Mobile Number")
    }
    
    func testDataSource() {
        XCTAssertTrue(presenter.dataSource.count == 2, "DataSource sections count Error")
    }
    
    func testBranchDictionary() {
        AuthDepedencyInjector.injectReferralDictionary(dictionary: nil)
        presenter = LoginWelcomePresenter()
        XCTAssertNil(presenter.referralFirstName, "Referral name should be nil")
        AuthDepedencyInjector.injectReferralDictionary(dictionary: ["refercode":"DHIN786", "fname":"Nitin"])
        presenter = LoginWelcomePresenter()
        XCTAssertNotNil(presenter.commonData.referralCode, "ReferralCode should not be nil")
        XCTAssertEqual(presenter.commonData.referralCode, "DHIN786", "ReferCode should be equal")
        XCTAssertNotEqual(presenter.commonData.referralCode, "", "ReferCode should not be equal")
        XCTAssertNotNil(presenter.referralFirstName, "Referral name should not be nil")
        XCTAssertEqual(presenter.commonData.referralCode, "DHIN786", "Refer name should be equal")
    }
    
    func testVerifyMobileNumber() {
        expectation = XCTestExpectation(description: "Verify Mobile Number Expectation")
        mockInteractor.verifyMobileNumber(mobileNumber: "7838387938")
        wait(for: [expectation], timeout: 0.5)
    }
    
}

extension LoginWelcomePresenterTests: LoginWelcomeInteractorToPresenterProtocol {

    func verificationMobileNumberRequestSucceeded(response: MobileVerifiedData?) {
        expectation.fulfill()
    }
    
    func verificationMobileNumberRequestFailed(error: ErrorData?) {
        
    }
    
}

class LoginWelcomeInteractorTests: BaseInteractorTests {
    
    let validResponse = "{\"is_verified\": 1, \"success\": 1, \"error\": \"{:}\", \"send_otp\": 0, \"has_password\": 1, \"existing_user\": 1}"
    
    var presenter: LoginWelcomeInteractorToPresenterProtocol!
    var interactor = LoginWelcomeInteractor()
    
    func testParseResponse() {
        interactor = LoginWelcomeInteractor()
        
        let mobileVerifiedData = interactor.parseResponse(data: validResponse.dictionaryObject)
        XCTAssertNotNil(mobileVerifiedData, "Valid response should not be nil")
        
        XCTAssertTrue(mobileVerifiedData!.isVerifiedUser, "isVerifiedUser should be true")
        XCTAssertTrue(mobileVerifiedData!.isSuccess, "isSuccess should be true")
        XCTAssertFalse(mobileVerifiedData!.isSendOtp, "isSendOtp should be false")
    }
}

extension LoginWelcomeInteractorTests: LoginWelcomePresenterToInteractorProtocol {
    
    func verifyMobileNumber(mobileNumber: String) {
        if AuthUtils.isValidPhoneNumber(mobileNumber) {
            let response = interactor.parseResponse(data: validResponse)
            presenter.verificationMobileNumberRequestSucceeded(response: response)
        } else {
            let errorData = interactor.getErrorDataFrom(error: "")
            presenter.verificationMobileNumberRequestFailed(error: errorData)
        }
    }
}


