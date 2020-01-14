//
//  ReferralCodeValidationTests.swift
//  AuthModuleTests
//
//  Created by Nitin Chadha on 14/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import XCTest
@testable import AuthModule

class ReferralCodeValidationPresenterTest: XCTestCase, ReferralCodeInteractorToPresenterProtocol {
    
    var mockInteractor: ReferralCodeValidationInteractorTest!
    var presenter: ReferralCodeValidationPresenter!
    
    var expectation: XCTestExpectation!
    
    override func setUp() {
        mockInteractor = ReferralCodeValidationInteractorTest()
        mockInteractor.presenter = self
        presenter = ReferralCodeValidationPresenter()
    }
    
    func testValidateReferralCodeFromDeepLink() {
        AuthDepedencyInjector.branchReferDictionary = branchMockDictionary
        expectation = XCTestExpectation(description: "Validating Referral Code")
        mockInteractor.verifyReferralCode(referralCode: referCode)
        wait(for: [expectation], timeout: 0.5)
    }
    
    func verifyReferralSuccessResponse(response: ReferralVerifyData) {
        expectation.fulfill()
    }
    
    func verifyReferralRequestFailed(error: ErrorData?) {
        
    }

}

class ReferralCodeValidationInteractorTest: BaseInteractorTests, ReferralCodePresenterToInteractorProtocol {
    
    weak var presenter: ReferralCodeInteractorToPresenterProtocol!
    var interactor: ReferralCodeInteractor!
    let validSuccessResponse = "{\"error\": \"\\n\\n\", \"success\": true, \"message\": \"You are eligible for referral\"}"
    let invalidResponse = "{\"success\" : \"false\"}"
    let failureResponse = "{\"success\": 0, \"error\": {\"field_errors\": {\"referral_code\": This referral code is invalid.}}}"
    
    override func setUp() {
        interactor = ReferralCodeInteractor()
        super.setUp()
    }
    
    func verifyReferralCode(referralCode:String) {
        interactor = ReferralCodeInteractor()
        if let response: ReferralVerifyData = interactor.parseResponse(dictionary: validSuccessResponse.dictionaryObject) {
            presenter.verifyReferralSuccessResponse(response: response)
        } else {
            presenter.verifyReferralRequestFailed(error: nil)
        }
    }
    
    func testParseResponse() {
        let response: ReferralVerifyData? = interactor.parseResponse(dictionary: validSuccessResponse.dictionaryObject)
        XCTAssertNotNil(response, "Referral name should not be nil")
        XCTAssertTrue(response!.isSuccess, "Referral code should be succeeded")
    }
}
