//
// Application.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation

///
/// Why?
///
public protocol ApplicationType {
    var isRunning: Bool { get }

    func run()
}

// MARK: - ApplicationType Implementation
public final class Application: ApplicationType {
    // MARK: - Public properties
    public private(set) var isRunning: Bool = false

    // MARK: - Private properties

    // MARK: - Public methods
    public func run() {
        isRunning = true
    }

    // MARK: - Private methods
    internal init() {
    }
}
