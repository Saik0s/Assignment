//
// ImageStyles.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import UIKit
import AsyncDisplayKit

extension Style where Node == ASNetworkImageNode {
    public static func userAvatar(_ url: URL? = nil) -> Style {
        return Style { node in
            node.url = url
            node.contentMode = .scaleAspectFill
            node.defaultImage = UIImage(named: "user")
            node.imageModificationBlock = { image in
                image.roundCorner(radius: 15, resize: CGSize(width: 30, height: 30)) ?? image
            }
            return node
        }
    }
}
