//
// Style.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import AsyncDisplayKit

public struct Style<Node> {
    internal let closure: (Node) -> Node

    public init(_ closure: @escaping (Node) -> Node) {
        self.closure = closure
    }
}

public protocol Stylizable: class {
}

extension ASDisplayNode: Stylizable {
}

extension Stylizable where Self: ASDisplayNode {
    @discardableResult
    public func stylize(as style: Style<Self>) -> Self {
        return style.closure(self)
    }
}
