//
// UsersListSectionController.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import AsyncDisplayKit
import IGListKit
import RxSwift
import RxCocoa

// MARK: - UsersListSectionController
public class UsersListSectionController: SectionController<UsersListUserCellNode> {
    public override func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionFooter]
    }

    public override func nodeBlockForSupplementaryElement(
            ofKind elementKind: String,
            at index: Int
    ) -> ASCellNodeBlock {
        return {
            return TailLoadingNode()
        }
    }

    public override func sizeRangeForSupplementaryElement(
            ofKind elementKind: String,
            at index: Int
    ) -> ASSizeRange {
        guard isLastSection
        else { return ASSizeRangeZero }
        return ASSizeRangeUnconstrained
    }
}
