//
// ApplicationTests.swift
// Created by Igor Tarasenko on 20/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import XCTest
@testable import Assignment

class ApplicationTests: XCTestCase {

    var application: Application!

    override func setUp() {
        super.setUp()
        application = Application()
    }

    override func tearDown() {
        application = nil
        super.tearDown()
    }

    // MARK: - run

    func test_run_shouldSet_isRunning() {
        application.run()
        XCTAssertEqual(application.isRunning, true)
    }
}
