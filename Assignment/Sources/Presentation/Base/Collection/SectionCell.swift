//
// SectionCell.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import AsyncDisplayKit
import Foundation
import IGListKit
import RxCocoa
import RxSwift

public protocol SectionCellType: class {
    associatedtype Model: Diffable

    static var cellNodeBlock: (Model) -> ASCellNodeBlock { get }
}
