//
// Presentable.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import UIKit

public protocol Presentable {
    // TODO: equatable using view controllers
    var viewController: UIViewController { get }
}

extension UIViewController: Presentable {
    public var viewController: UIViewController {
        return self
    }
}
