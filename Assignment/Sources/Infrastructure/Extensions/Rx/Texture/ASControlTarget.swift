//
// ASControlTarget.swift
//
// Created by Igor Tarasenko
//

import Foundation

import UIKit
import AsyncDisplayKit
import RxSwift
import RxCocoa

// This should be only used from `MainScheduler`
public final class ASControlTarget: RxTarget {

    public typealias Control = AsyncDisplayKit.ASControlNode
    public typealias ControlEvents = AsyncDisplayKit.ASControlNodeEvent
    public typealias Callback = (Control) -> Void

    private let selector: Selector = #selector(ASControlTarget.userHandler(_:))

    private weak var control: Control?
    private let controlEvents: ASControlNodeEvent
    private var callback: Callback?

    public init(
            control: Control,
            controlEvents: ASControlNodeEvent,
            callback: @escaping Callback
    ) {

        MainScheduler.ensureExecutingOnScheduler()

        self.control = control
        self.controlEvents = controlEvents
        self.callback = callback

        super.init()

        control.addTarget(
                self,
                action: selector,
                forControlEvents: controlEvents
        )

        let method = self.method(for: selector)
        if method == nil {
            fatalError("Can't find method")
        }
    }

    @objc public func userHandler(_: Control!) {

        if let callback = self.callback, let control = self.control {
            callback(control)
        }
    }

    public override func dispose() {

        super.dispose()
        control?.removeTarget(
                self,
                action: selector,
                forControlEvents: controlEvents
        )
        callback = nil
    }
}
