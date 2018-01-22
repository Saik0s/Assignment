//
// ASButtonNode+Rx.swift
//
// Created by Igor Tarasenko
//

import Foundation
import UIKit
import AsyncDisplayKit
import RxSwift
import RxCocoa

extension Reactive where Base: ASButtonNode {
    public var tap: ControlEvent<Void> {
        return controlEvent(ASControlNodeEvent.touchUpInside)
    }
}
