//
//  UserConfirmationPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 31/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class UserConfirmationPresenter {

    //var view: UserConfirmationViewController?
    
    var interactor: UserConfirmationInteractor?
    
    var verificationData: OtpVerifiedData
    
    var profileData: ReverseProfileData?
    
    var dataProvider: DataProvider!
    
    init(data: OtpVerifiedData) {
        self.verificationData = data
        
        if verificationData.isExistingUser {
            dataProvider = DataProvider(for: ((UserDataManager.shared.activeUser?.previouslySynced as? Bool ?? false) ? .previouslySynced : .neverSynced))
        } else {
            dataProvider = DataProvider(for: .newUser)
        }
        
        AuthDepedencyInjector.AnalyticsDelegate?.logCategory(event: "CONGRATULATIONS PAGE", dictionary: nil)
        let attributes = ["screenName": "I want goCash Plus Page","cdCatQuery" :"Social"]
        AuthDepedencyInjector.AnalyticsDelegate?.pushEvent(withName: "openScreen", withAttributes: attributes)
    }
    
    func getReverseProfiles() {
        //view?.showActivityIndicator()
        //interactor?.getReverseProfiles()
    }
    
    func reverseProfileSuccessResponse(response: ReverseProfileData) {
        //view?.hideActivityIndicatorView()
    }
    
    func reverseProfileFailed(error: ErrorData?) {
        //view?.hideActivityIndicatorView()
    }

}

enum UserType: String {
    case newUser = "newUser"
    case previouslySynced = "previouslySynced"
    case neverSynced = "neverSynced"
}

struct DataProvider {
    
    var userType: UserType
    var stringDictionary: Dictionary<AnyHashable, Any>
    
    init(for userType:UserType) {
        self.userType = userType
        
        switch(userType) {
        case .newUser:
            stringDictionary = FireBaseHandler.getDictionaryFor(keyPath: .syncGoContactsNewUser, dbPath: .goAuthDatabase)
            break
        case .previouslySynced:
            stringDictionary = FireBaseHandler.getDictionaryFor(keyPath: .syncGoContactsPreviouslySynced, dbPath: .goAuthDatabase)
        case .neverSynced:
            stringDictionary = FireBaseHandler.getDictionaryFor(keyPath: .syncGoContactsneverSynced, dbPath: .goAuthDatabase)
        }
    }
    
    var userPersuastionTitle: String {
        guard var value = stringDictionary["h"] as? String else {
            return ""
        }
        
        let userName = UserDataManager.shared.activeUser?.firstname ?? ""
        value = value.replacingOccurrences(of: "{{First_Name}}", with: userName)
        return value
    }
    
    var userPersuastionSubtitle: String {
        guard let value = stringDictionary["hst"] as? String else {
            return ""
        }
        return value
    }
    
    var screenTitle: String {
        guard let value = stringDictionary["st"] as? String else {
            return ""
        }
        return value
    }
    
    var screenSubtitle: String {
        guard let value = stringDictionary["sst"] as? String else {
            return ""
        }
        return value
    }
    
    var explanationTitle1: String {
        guard let value = stringDictionary["et1"] as? String else {
            return ""
        }
        return value
    }
    
    var explanation1: String {
        guard let value = stringDictionary["e1"] as? String else {
            return ""
        }
        return value
    }
    
    var explanationTitle2: String {
        guard let value = stringDictionary["et2"] as? String else {
            return ""
        }
        return value
    }
    
    var explanation2: String {
        guard let value = stringDictionary["e2"] as? String else {
            return ""
        }
        return value
    }
    
    var userContactsDetail: String {
        guard let value = stringDictionary["rp"] as? String else {
            return ""
        }
        return value
    }
    
    var linkPhonebookButtonTitle: String {
        guard let value = stringDictionary["bt"] as? String else {
            return ""
        }
        return value
    }
}

