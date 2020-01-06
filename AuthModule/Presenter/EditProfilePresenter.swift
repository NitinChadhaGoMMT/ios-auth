//
//  EditProfilePresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 05/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import Foundation

class EditProfilePresenter {
    
    class UserProfile {
        var nameTitle, firstName, middleName, lastName: String?
        var dob, mobile, email, emailB, emailA: String?
        var gstn, company, companyAddress, companyPhone:String?
        
        init(user: User) {
            nameTitle = user.title
            firstName = user.firstname
            middleName = user.middlename
            lastName = user.lastname
            dob = user.dob
            mobile = user.phone
            email = AuthUtils.checkForDummyEmail(user.email)
            emailB = AuthUtils.checkForDummyEmail(user.emailBusiness)
            emailA = AuthUtils.checkForDummyEmail(user.emailAdmin)
            gstn = user.gstin
            company = user.company
            
            companyAddress = user.companyAddress
            companyPhone = user.companyPhone

        }
    }

    var view: EditProfileViewController?

    init() {
        
    }
}
