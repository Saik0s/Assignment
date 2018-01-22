//
// Fonts.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import UIKit

extension UIFont {
    public enum Name: String {
        case latoBlack = "Lato-Black"
        case latoBlackItalic = "Lato-BlackItalic"
        case latoBold = "Lato-Bold"
        case latoBoldItalic = "Lato-BoldItalic"
        case latoHairline = "Lato-Hairline"
        case latoHairlineItalic = "Lato-HairlineItalic"
        case latoItalic = "Lato-Italic"
        case latoLight = "Lato-Light"
        case latoLightItalic = "Lato-LightItalic"
        case latoRegular = "Lato-Regular"
        case openSansBold = "OpenSans-Bold"
        case openSansBoldItalic = "OpenSans-BoldItalic"
        case openSansExtraBold = "OpenSans-ExtraBold"
        case openSansExtraBoldItalic = "OpenSans-ExtraBoldItalic"
        case openSansItalic = "OpenSans-Italic"
        case openSansLight = "OpenSans-Light"
        case openSansLightItalic = "OpenSans-LightItalic"
        case openSansRegular = "OpenSans-Regular"
        case openSansSemiBold = "OpenSans-SemiBold"
        case openSansSemiBoldItalic = "OpenSans-SemiBoldItalic"

        public func of(size: CGFloat) -> UIFont {
            return UIFont(name: rawValue, size: size).unwrapped(
                    or: UIFont.systemFont(ofSize: size)
            )
        }
    }

    public static func font(_ name: Name, size: CGFloat) -> UIFont {
        return name.of(size: size)
    }
}
