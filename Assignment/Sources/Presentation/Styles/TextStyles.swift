//
// TextStyles.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import AsyncDisplayKit

private func setDefaultProperties(to node: ASTextNode, with title: NSAttributedString) {
    node.attributedText = title
    node.maximumNumberOfLines = 1
    node.truncationMode = .byTruncatingTail
}

extension Style where Node == ASTextNode {
    public static func userTitle(_ text: String) -> Style {
        return Style { node in
            let title = text.uppercased().attributed
            title.set(.font(.systemFont(ofSize: 12)))
            title.set(.foregroundColor(.greyBlue))
            setDefaultProperties(to: node, with: title)
            return node
        }
    }

    public static func userDefault(_ text: String) -> Style {
        return Style { node in
            let title = text.attributed
            title.set(.font(.systemFont(ofSize: 12)))
            title.set(.foregroundColor(.gunmetal))
            setDefaultProperties(to: node, with: title)
            return node
        }
    }
}
