//
// ASEditableTextNode+Rx.swift
//
// Created by Igor Tarasenko
//

import UIKit
import AsyncDisplayKit
import RxSwift
import RxCocoa

extension Reactive where Base: ASEditableTextNode {

    public var text: ControlProperty<String?> {
        return value
    }

    public var value: ControlProperty<String?> {
        return base.textView.rx.text
    }
}
