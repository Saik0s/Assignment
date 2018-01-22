//
// NSMutableAttributedString.swift
// Created by Igor Tarasenko on 16/10/17.
// Copyright © 2017 Igor Tarasenko
// Licensed under the MIT license, see LICENSE file
//

import UIKit

public enum Attribute {
    case font(UIFont)
    case foregroundColor(UIColor)
}

extension NSMutableAttributedString {
    public func set(_ attribute: Attribute) {
        let range = NSRange(location: 0, length: length)
        switch attribute {
            case let .font(font):
                addAttribute(.font, value: font, range: range)
            case let .foregroundColor(color):
                addAttribute(.foregroundColor, value: color, range: range)
        }
    }
}
