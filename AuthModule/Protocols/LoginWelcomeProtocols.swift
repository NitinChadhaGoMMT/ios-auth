//
//  LoginWelcomeProtocols.swift
//  AuthModule
//
//  Created by Nitin Chadha on 13/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginWelcomeProtocols: NSObject {

}

protocol LoginWelcomeViewToPresenterProtocol: class{
    
    var dataSource: [[LoginCellType]] { get }
    
    var currentMobileNumber: String? { get set }
    
    var referralCode: String? { get }
    
    var isFbSignup: Bool { get set }

    var branchDictionary: NSDictionary? { get }
    
    func isValidPhoneNumber(mobileNumber: String?) -> Bool
    
    func performInitialConfiguration()
    
    func checkForMobileConnect()
    
    func verifyMobileNumber(number: String)
    
    func logGAClickEvent(_ type:String)
    
    func resetReferralCode()
    
    func validateReferralCode(_referralCode: String?, isBranchFlow: Bool)
}

protocol LoginWelcomePresenterToViewProtocol: class{

}

protocol LoginWelcomePresenterToRouterProtocol: class {
    //static func createModule()-> NoticeViewController
    ///func pushToMovieScreen(navigationConroller:UINavigationController)
}

protocol LoginWelcomePresenterToInteractorProtocol: class {
    //var presenter:InteractorToPresenterProtocol? {get set}
    //func fetchNotice()
}

protocol LoginWelcomeInteractorToPresenterProtocol: class {
    //func noticeFetchedSuccess(noticeModelArray:Array<NoticeModel>)
    //func noticeFetchFailed()
}
