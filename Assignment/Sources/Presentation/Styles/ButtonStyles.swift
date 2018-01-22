//
// ButtonStyles.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import UIKit
import AsyncDisplayKit

extension Style where Node == ASButtonNode {
    public static var remove: Style {
        return Style { node in
            node.setBackgroundImage(
                    UIImage(named: "delete"),
                    for: .normal
            )
            return node
        }
    }
}
