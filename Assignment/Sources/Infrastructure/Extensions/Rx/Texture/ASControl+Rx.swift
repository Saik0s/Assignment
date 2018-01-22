//
// ASControl+Rx.swift
//
// Created by Igor Tarasenko
//

import Foundation
import UIKit
import AsyncDisplayKit
import RxSwift
import RxCocoa

extension Reactive where Base: ASControlNode {

    public var isEnabled: Binder<Bool> {
        return Binder(base) { control, value in
            control.isEnabled = value
        }
    }

    public var isSelected: Binder<Bool> {
        return Binder(base) { control, selected in
            control.isSelected = selected
        }
    }

    public var isHidden: Binder<Bool> {
        return Binder(base) { node, hidden in
            node.isHidden = hidden
        }
    }

    public func controlEvent(_ controlEvents: ASControlNodeEvent) -> RxCocoa.ControlEvent<Swift.Void> {

        let source: Observable<Void> = Observable.create { [weak control = self.base]
        observer in
            MainScheduler.ensureExecutingOnScheduler()

            guard let control = control
            else {

                observer.on(.completed)
                return Disposables.create()
            }

            let controlTarget = ASControlTarget(
                    control: control,
                    controlEvents: controlEvents
            ) { _ in
                observer.on(.next(()))
            }

            return Disposables.create(with: controlTarget.dispose)
        }.takeUntil(deallocated)

        return ControlEvent(events: source)
    }

    static func value<C: ASControlNode, T>(
            _ control: C,
            getter: @escaping (C) -> T,
            setter: @escaping (C, T) -> Void
    ) -> ControlProperty<T> {

        let source: Observable<T> = Observable.create { [weak weakControl = control]
        observer in
            guard let control = weakControl
            else {
                observer.on(.completed)
                return Disposables.create()
            }

            observer.on(.next(getter(control)))

            let controlTarget = ASControlTarget(
                    control: control,
                    controlEvents: [.valueChanged]
            ) { _ in
                if let control = weakControl {
                    observer.on(.next(getter(control)))
                }
            }

            return Disposables.create(with: controlTarget.dispose)
        }.takeUntil((control as NSObject).rx.deallocated)
        let bindingObserver = Binder(
                control,
                binding: setter
        )

        return ControlProperty<T>(values: source, valueSink: bindingObserver)
    }
}
