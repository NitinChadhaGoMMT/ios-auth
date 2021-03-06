//
//  UserDataManager.swift
//  AuthModule
//
//  Created by Nitin Chadha on 29/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import CoreData

let kTimeLoggedInFetch = "kTimeLoggedInFetch"
let kTimeSyncFetch = "kTimeSyncFetch"

class UserDataManager {

    static var shared = UserDataManager()
    
    private init() {
        resumeApplicationState()
    }
    
    var activeUser: User?
    
    var isWAChecked: Bool = false
    
    var isLoggedIn: Bool {
        return activeUser != nil
    }
    
    var isUpdate = false
    
    var didUserLoginInCurrentSession = false
    
    func resumeApplicationState() {
        if let ibiboUserName: String = AuthCache.shared.getUserDefaltObject(forKey: "username") as? String {
            self.activeUser = DBHelper.shared.fetchUser(withPredicate: NSPredicate(format: "username = %@", ibiboUserName))
        }
    }
    
    func clearCookiesAndCache() {
        if let storedCookies = HTTPCookieStorage.shared.cookies {
            for cookie in storedCookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        URLCache.shared.removeAllCachedResponses()
    }
    
    func updateLoggedInUser(to dictionary: Dictionary<String, Any>) {
        
        let username = dictionary["username"] as? String
        
        if let dbUser = activeUser, let _username = dbUser.username {
            if username?.caseInsensitiveCompare(_username) != .orderedSame {
                self.logout(type: .api)
                activeUser = DBHelper.shared.createNewUserEntity()
            }
        } else {
            isUpdate = true
            activeUser = DBHelper.shared.createNewUserEntity()
        }

        activeUser?.username = dictionary["username"] as? String
        activeUser?.firstname = dictionary["firstname"] as? String
        activeUser?.middlename = dictionary["middlename"] as? String
        activeUser?.lastname = dictionary["lastname"] as? String
        activeUser?.phone = dictionary["phone"] as? String
        activeUser?.address = dictionary["address"] as? String
        activeUser?.email = dictionary["email"] as? String
        activeUser?.title = dictionary["usertitle"] as? String
        activeUser?.dob = dictionary["dob"] as? String
        activeUser?.hasPassword = dictionary["has_password"] as? NSNumber
        activeUser?.emailState = dictionary["email_id_state"] as? String
        activeUser?.canAddPassword = dictionary["can_add_password"] as? NSNumber
        activeUser?.referralCode = dictionary["user_code"] as? String
        activeUser?.branchlink = dictionary["branch_link"] as? String
        activeUser?.fbLinked = NSNumber.init(booleanLiteral: dictionary["fb_linked"] as? Bool ?? false)
        activeUser?.imageURL = dictionary["image_url"] as? String
        
        
        if let userId = dictionary["userId"] as? String {
            activeUser?.userid = userId
        } else if let userId = dictionary["userId"] as? NSNumber {
            activeUser?.userid = userId.stringValue
        }
        
        if let mobileVerified: Bool = dictionary["mobile_verified"] as? Bool {
            activeUser?.isVerified = NSNumber(booleanLiteral: mobileVerified)
        } else {
            activeUser?.isVerified = 0
        }
        
        if let dateFlag = dictionary["date_flag"] as? Bool {
            activeUser?.dateFlag = NSNumber(booleanLiteral: dateFlag)
        } else {
            activeUser?.dateFlag = 0
        }
        
        if let previouslySynced = dictionary["previously_sync"] as? Bool {
            activeUser?.previouslySynced = NSNumber(booleanLiteral: previouslySynced)
        } else {
            activeUser?.previouslySynced = 0
        }
        
        if let profileidP = dictionary["profile_id"] as? String, !AuthUtils.isEmptyString(profileidP) {
            activeUser?.profileIdPersonal = profileidP
        }
        
        
        if let mobVerified = dictionary["mobile_verified"] as? Bool {
            activeUser?.isVerified = NSNumber.init(booleanLiteral: mobVerified)
        }
        
        if let businessDictionary = dictionary["business_info"] as? Dictionary<AnyHashable, Any> {

            if let isBusinessProfileExist: NSNumber = businessDictionary["exists"] as? NSNumber {
                self.activeUser?.hasBusinessProfile = isBusinessProfileExist
            } else {
                self.activeUser?.hasBusinessProfile = 0
            }
            
            if let businessInfo = businessDictionary["data"] as? Dictionary<AnyHashable, Any> {
                
                if let isBusinessProfileVerified = businessInfo["email_verified"] as? NSNumber {
                    self.activeUser?.isBusinessVerified = isBusinessProfileVerified
                } else {
                    self.activeUser?.isBusinessVerified = 0
                }
                
                if self.activeUser?.isBusinessVerified == false {
                    AuthUtils.setBusinessProfileSelected(false)
                }
                
                if let gstin = businessInfo["gstin"] as? String {
                    self.activeUser?.gstin = gstin
                } else {
                    self.activeUser?.gstin = ""
                }
                
                self.activeUser?.emailBusiness = businessInfo["business_email"] as? String ?? ""
                self.activeUser?.emailAdmin = businessInfo["admin_email"] as? String ?? ""
                self.activeUser?.profileIdBusiness = businessInfo["profile_id"] as? String ?? ""
                self.activeUser?.company = businessInfo["company"] as? String ?? ""
                self.activeUser?.companyAddress = businessInfo["company_address"] as? String ?? ""
                self.activeUser?.companyPhone = businessInfo["company_phone"] as? String ?? ""
            }
            
        } else {
            self.activeUser?.hasBusinessProfile = 0
            self.activeUser?.isBusinessVerified = 0
            AuthUtils.setBusinessProfileSelected(false)
        }
        
        DBHelper.shared.saveContext()
        
        AuthCache.shared.setUserDefaltObject(username, forKey: "username")
        AuthCache.shared.setUserDefaltBool(true, forKey: "businessProfileData")
        
        if let firebase_token = dictionary["firebase_token"] as? String, !firebase_token.isEmpty {
            AuthCache.shared.setUserDefaltObject(firebase_token, forKey: "firebase_token")
        }
        if let ipl_firebase_token = dictionary["ipl_firebase_token"] as? String, !ipl_firebase_token.isEmpty {
            AuthCache.shared.setUserDefaltObject(ipl_firebase_token, forKey: "ipl_firebase_token")
        }
        
        updateUserTraits()
        
        if isUpdate {
            AuthUtils.resetCountToLaunch()
        }
        
        if self.isLoggedIn {
            KeychainLoginHandler.shared.saveCurrentUser()
        }
    }
    
    func logout(type: LogoutType) {
        print("Logout User")
        KeychainLoginHandler.shared.deleteUser()
        AuthCache.shared.setUserDefaltBool(false, forKey: "is_user_enrolled_for_act_deals")
        AuthUtils.setBusinessProfileSelected(false)
        if ( self.activeUser != nil) {
            AuthService.goServiceLogout(type)
        }
        isWAChecked = false
        clearCookiesAndCache()
        if let user = self.activeUser {
            DBHelper.shared.managedObjectContext.delete(user)
            activeUser = nil
        }
        AuthCache.shared.setUserDefaltInteger(0, forKey: kTimeLoggedInFetch)
        AuthCache.shared.setUserDefaltInteger(0, forKey: kTimeSyncFetch)
        AuthCache.shared.setUserDefaltObject(nil, forKey: "username")
        AuthCache.shared.removeDefaultObject(forKey: "NotificationsArray")
        AuthCache.shared.setUserDefaltObject(nil, forKey: "LoggedInUserId")
        DBHelper.shared.saveContext()
        
    }
    
    func updateUserTraits() {
        //<NITIN>
    }
    
    func accessTokenUpdated() {
        //<NITIN>
    }
    
    static func updateLoggedInUserGoCash() {
        let moc = DBHelper.shared.managedObjectContext
        var user: User? = NSEntityDescription.insertNewObject(forEntityName: "User", into: moc) as? User
        
    }
    
}
