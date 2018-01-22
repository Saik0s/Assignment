//
// ExpressibleByStringLiteral.swift
//
// Created by Igor Tarasenko
//

import Foundation

extension ExpressibleByStringLiteral where StringLiteralType == String {
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
