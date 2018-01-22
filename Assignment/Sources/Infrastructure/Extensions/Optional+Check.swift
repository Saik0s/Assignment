//
// Optional+Check.swift
//
// Created by Igor Tarasenko
//

import Foundation

public protocol EmptiedContainer {
    var isEmpty: Bool { get }
}

extension String: EmptiedContainer {
} // String already has an `isEmpty` property

extension Array: EmptiedContainer {
} // Array already has an `isEmpty` property via `CollectionType`

extension Optional where Wrapped: EmptiedContainer {
    public var isNilOrEmpty: Bool {
        switch self {
            case let .some(container):
                return container.isEmpty
            case .none:
                return true
        }
    }

    public var isNotEmpty: Bool {
        switch self {
            case let .some(container):
                return !container.isEmpty
            case .none:
                return false
        }
    }
}

extension Optional {
    public func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }

    @discardableResult
    public func ifSome(_ handler: (Wrapped) -> Void) -> Optional {
        switch self {
            case let .some(wrapped):
                handler(wrapped)
                return self
            case .none:
                return self
        }
    }

    @discardableResult
    public func ifNone(_ handler: () -> Void) -> Optional {
        switch self {
            case .some:
                return self
            case .none:
                handler()
                return self
        }
    }
}
