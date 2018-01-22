//
// AutoListDiffable.swift
// Switchback
//
// Created by Igor Tarasenko
// Copyright (c) 2017 . All rights reserved.
//

import Foundation

public protocol AutoListDiffable: Diffable {
    var id: Int { get }
}

extension AutoListDiffable {
    public var diffIdentifier: String {
        return "\(id)"
    }
}
