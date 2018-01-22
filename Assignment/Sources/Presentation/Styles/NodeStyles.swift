//
// NodeStyles.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import AsyncDisplayKit

extension Style where Node: ASDisplayNode {
    public static var defaultContainer: Style {
        return Style { node in
            node.backgroundColor = .white
            return node
        }
    }
}
