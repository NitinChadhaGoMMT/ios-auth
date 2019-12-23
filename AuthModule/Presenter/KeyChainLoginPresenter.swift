//
//  KeyChainLoginPresenter.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class KeyChainLoginPresenter {

    weak var view: KeyChainLoginViewController?
    var dataSource = Array(KeychainLoginHandler.shared.getAllUsersInfo().values)
    
    init() {
        sortDataArray()
    }
    
    func sortDataArray(){
        dataSource.sort { (firstElement, secondElement) -> Bool in
            if let firstDictionary = firstElement as? [String:Any],let secondDictionary = secondElement as? [String:Any] ,let firstTimeStamp = firstDictionary["timeStamp"] as? Int,let secontTimeStamp = secondDictionary["timeStamp"] as? Int{
                return firstTimeStamp > secontTimeStamp
            }
            
            return true
        }
    }
}
