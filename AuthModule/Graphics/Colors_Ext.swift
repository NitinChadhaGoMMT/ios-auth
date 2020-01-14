//
//  Colors_EXT.swift
//  AuthModule
//
//  Created by Nitin Chadha on 09/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit


extension UIColor {

    static var goBlue: UIColor = UIColor(red: 0.1333333, green: 0.462745098039216, blue: 0.890196078431373, alpha: 1.0)
    
    static var lightBlue: UIColor = UIColor(red: 0.1333333, green: 0.462745098039216, blue: 0.890196078431373, alpha: 0.1)
    //return UIColor(red: 34.0 / 255.0, green: 118.0 / 255.0, blue: 227.0 / 255.0, alpha: 1.0)
    
    static var darkBlue: UIColor = UIColor(red: 0.098039215686275, green: 0.427450980392157, blue: 0.717647058823529, alpha: 1.0)
    //return UIColor(red: 25.0 / 255.0, green: 94.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
    
    static var goOrange: UIColor = UIColor(red: 1.0, green: 0.427450980392157, blue: 0.219607843137255, alpha: 1.0)
    //    static var goOrange: UIColor = UIColor(red: 1.0, green: 109.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0)
    
    static var darkOrange: UIColor = UIColor(red: 0.92156862745098, green: 0.380392156862745, blue: 0.145098039215686, alpha: 1.0)
    //    static var darkOrange: UIColor = UIColor(red: 235.0 / 255.0, green: 97.0 / 255.0, blue: 37.0 / 255.0, alpha: 1.0)
    
    static var goBlack: UIColor = UIColor(red: 0.07843137254902, green: 0.094117647058824, blue: 0.137254901960784, alpha: 1.0)
    //    static var blueBlack: UIColor = UIColor(red: 20.0 / 255.0, green: 24.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    
    static var goWhite: UIColor = UIColor(white: 1.0, alpha: 1.0)
    
    static var bgBlue: UIColor = UIColor(red: 0.937254901960784, green: 0.952941176470588, blue: 0.972549019607843, alpha: 1.0)
    //    static var bgBlue: UIColor = UIColor(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    
    static var iconGrey: UIColor = UIColor(red: 0.392156862745098, green: 0.47843137254902, blue: 0.592156862745098, alpha: 1.0)
    //    static var iconGrey: UIColor = UIColor(red: 100.0 / 255.0, green: 122.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
    
    static var goDarkGrey: UIColor = UIColor(white: 0.466666666666667, alpha: 1.0)
    //    static var brownishGrey: UIColor = UIColor(white: 119.0 / 255.0, alpha: 1.0)
    
    static var goLightGrey: UIColor = UIColor(white: 0.76078431372549, alpha: 1.0)
    //    static var goLightGrey: UIColor = UIColor(white: 194.0 / 255.0, alpha: 1.0)
    
    static var goRed: UIColor = UIColor(red: 1.0, green: 0.082352941176471, blue: 0.082352941176471, alpha: 1.0)
    //    static var warning: UIColor = UIColor(red: 1.0, green: 21.0 / 255.0, blue: 21.0 / 255.0, alpha: 1.0)
    
    static var goGreen: UIColor = UIColor(red: 0.094117647058824, green: 0.631372549019608, blue: 0.376470588235294, alpha: 1.0)
    //    static var success: UIColor = UIColor(red: 24.0 / 255.0, green: 161.0 / 255.0, blue: 96.0 / 255.0, alpha: 1.0)
    
    static var lineGrey: UIColor = UIColor(red: 0.937254902, green: 0.9529411765, blue: 0.9529411765, alpha: 1.0)
    
    //    static var success: lineGrey = UIColor(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    
    static var paleGrey: UIColor = UIColor(red: 0.95686274509, green: 0.96470588235, blue: 0.97647058823, alpha: 1.0)
    
    //    static var success: lineGrey = UIColor(red: 244.0 / 255.0, green: 246.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
    
    static var golden: UIColor = UIColor(red: 1.0, green: 0.7607843137, blue: 0.2901960784, alpha: 1.0)
    
    static var brown: UIColor = UIColor(red: 132.0/255.0, green: 100.0/255.0, blue: 24.0/255.0, alpha: 1.0)
    
    static var purple: UIColor = UIColor(red: 77.0/255.0, green: 62.0/255.0, blue: 252.0/255.0, alpha: 1.0)
    
    static var customGray: UIColor {
        return customGrayColor()
    }
    
    static var customBlue: UIColor {
        return colorWithHexValue("#2E69B3")
    }
    
    static func backgroundColor() -> UIColor {
        return colorWithHexValue("#F3F3F3")
    }
    
    static func customOrangeColor() -> UIColor {
        return colorWithHexValue("#F26722")
    }
    
    static func customBlueColor() -> UIColor {
        return colorWithHexValue("#2E69B3")
    }
    
    static func customGrayColor() -> UIColor {
        return colorWithHexValue("#595959")
    }
    
    static func customLightGrayColor() -> UIColor {
        return colorWithHexValue("#9B9B9B")
    }
    
    static func colorWithHexValue (_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        
        if hexString.length == 0 {
            return UIColor.gray
        }
        
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
