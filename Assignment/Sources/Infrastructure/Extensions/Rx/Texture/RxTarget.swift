//
// RxTarget.swift
//
// Created by Igor Tarasenko
//

import Foundation
import RxSwift
import RxCocoa

public class RxTarget: NSObject, Disposable {

    private var retainSelf: RxTarget?

    public override init() {

        super.init()
        retainSelf = self

#if TRACE_RESOURCES
        _ = Resources.incrementTotal()
#endif

#if DEBUG
        MainScheduler.ensureExecutingOnScheduler()
#endif
    }

    public func dispose() {

#if DEBUG
        MainScheduler.ensureExecutingOnScheduler()
#endif
        retainSelf = nil
    }

#if TRACE_RESOURCES
    deinit {

        _ = Resources.decrementTotal()
    }
#endif
}
