//
//  Strings_ext.swift
//  AuthModule
//
//  Created by Nitin Chadha on 23/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func convertHTMLTagsIntoString(boldFont: UIFont = UIFont.caption1) -> NSAttributedString {
        let string = self.replacingOccurrences(of: "\\n", with: "\n")
        if string.contains("<b>") {
            let boldStrings = string.components(separatedBy: " ").filter { (aString) -> Bool in
                aString.contains("<b>")
            }
            let aHeader = string.replacingOccurrences(of: "<b>", with:"")
            let attributedString = NSMutableAttributedString(string: aHeader)
            
            for boldString in boldStrings {
                let aBoldString = boldString.replacingOccurrences(of: "<b>", with:"")
                let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
                let range = (aHeader as NSString).range(of: aBoldString)
                attributedString.addAttributes(boldFontAttribute, range: range)
            }
            return attributedString
        }
        return NSAttributedString(string: string)
    }
}
