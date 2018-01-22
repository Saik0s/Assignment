//
// ASTextNode+Rx.swift
//
// Created by Igor Tarasenko
//

import Foundation
import UIKit
import AsyncDisplayKit
import RxSwift
import RxCocoa
import RxOptional

extension Reactive where Base: ASTextNode {

    public var text: ControlProperty<String?> {
        return value
    }

    public var value: ControlProperty<String?> {
        return ASControlNode.rx.value(
                base,
                getter: { (textNode: ASTextNode) in
                    textNode.attributedText?.string
                },
                setter: { (textNode: ASTextNode, value: String?) in
                    guard let attributedText = textNode.attributedText,
                          let value = value,
                          attributedText.string != value
                    else {
                        textNode.attributedText = NSAttributedString()
                        return
                    }

                    let mutable =
                            NSMutableAttributedString(attributedString: attributedText)
                    mutable.mutableString.setString(value)
                    textNode.attributedText = mutable
                }
        )
    }
}
