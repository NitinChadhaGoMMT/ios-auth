//
//  UIFont_Ext.swift
//  AuthModule
//
//  Created by Nitin Chadha on 09/01/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

enum FontFamilyType: Int {
    case qsBold, qsMedium, sfProRegular, sfProBold
}

enum FontType: Int {
    case light, regular, medium, semiBold, bold,Black
}

private enum FontSize: CGFloat {
    case smallest = 11.0
    case small = 12.0
    case regular = 14.0
    case medium = 16.0
    case large = 18.0
    case xLarge = 24.0
    case xxLarge = 32.0
}

extension UIFont {
    
    static let title1 = UIFont.fontWith(fontType: .qsBold, size: .xLarge)
    static let label1 = UIFont.fontWith(fontType: .qsBold, size: .regular)
    static let title2 = UIFont.fontWith(fontType: .qsBold, size: .large)
    static var title3 = UIFont.fontWith(fontType: .qsBold, size: .medium)
    static var caption2 = UIFont.fontWith(fontType: .sfProRegular, size: .small)
    static var tiny = UIFont.fontWith(fontType: .sfProRegular, size: .smallest)
    static var caption1: UIFont = UIFont.fontWith(fontType: .sfProBold, size: .small)
    
    private static func fontWith(fontType: FontFamilyType, size: FontSize) -> UIFont {
        
        var font: UIFont?
        let size: CGFloat = size.rawValue //We can add device specific multiplier here if required.
        
        switch fontType {
            
        case .qsBold:
            font = UIFont(name: "Quicksand-Bold", size: size)
            
        case .qsMedium:
            font = UIFont(name: "Quicksand-Medium", size: size)
            
        case .sfProRegular:
            font = UIFont(name: "SFUIText-Regular", size: size)
            
        case .sfProBold:
            font = UIFont(name: "SFUIText-Bold", size: size)
        }
        
        return font!
    }
    
    static func fontsWith(fontType: FontFamilyType, size: CGFloat) -> UIFont {
        
        var font: UIFont?
        
        switch fontType {
            
        case .qsBold:
            font = UIFont(name: "Quicksand-Bold", size: size)
            
        case .qsMedium:
            font = UIFont(name: "Quicksand-Medium", size: size)
            
        case .sfProRegular:
            font = UIFont(name: "SFUIText-Regular", size: size)
            
        case .sfProBold:
            font = UIFont(name: "SFUIText-Bold", size: size)
        }
        
        return font!
    }
    
    static func fontWithType(_ fontType: FontType = .regular, andSize size: CGFloat) -> UIFont {
        
        var font: UIFont
        
        switch fontType {
        case .light:
            font = UIFont.lightFontWithSize(size)
            
        case .regular:
            font = UIFont.regularFontWithSize(size)
            
        case .medium:
            font = UIFont.mediumFontWithSize(size)
            
        case .semiBold:
            font = UIFont.semiBoldFontWithSize(size)
        
        case .bold:
            font = UIFont.boldFontWithSize(size)
        case .Black:
            font = UIFont.boldFontWithSize(size)
        }
        
        return font
    }
    
    static fileprivate func lightFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Light", size: size)!
    }
    
    static fileprivate func regularFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Regular", size: size)!
    }
    
    static fileprivate func mediumFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Medium", size: size)!
    }
    
    static fileprivate func semiBoldFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Semibold", size: size)!
    }
    
    static fileprivate func boldFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Bold", size: size)!
    }
}
