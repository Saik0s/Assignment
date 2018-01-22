//
// SectionController.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import AsyncDisplayKit
import Foundation
import IGListKit
import RxCocoa
import RxOptional
import RxSwift

public class SectionController<Cell>: ListSectionController,
                                      ASSectionController,
                                      ListSupplementaryViewSource,
                                      ASSupplementaryNodeSource
        where Cell: ASCellNode & SectionCellType {
    public var onSelectIndex: Observable<Int> {
        return didSelectIndex.asObservable()
    }

    public var onUpdateContext: Observable<ASBatchContext> {
        return batchContext.asObservable().filterNil()
    }

    public var cellNodeBlock: (Cell.Model) -> ASCellNodeBlock = Cell.cellNodeBlock

    private let didSelectIndex: PublishSubject<Int> = PublishSubject()
    private let batchContext: Variable<ASBatchContext?> = Variable(nil)

    private var object: Cell.Model?

    public override func didUpdate(to object: Any) {
        if let object = object as? DiffableBox<Cell.Model> {
            self.object = object.value
        }
    }

    // MARK: - ListSectionController

    public override func sizeForItem(at index: Int) -> CGSize {
        return ASIGListSectionControllerMethods.sizeForItem(at: index)
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }

    // MARK: - ASSectionController

    public func nodeBlockForItem(at _: Int) -> ASCellNodeBlock {
        guard let object = object
        else { return ASCellNode.emptyNodeBlock }

        return cellNodeBlock(object)
    }

    public func shouldBatchFetch() -> Bool {
        return !(batchContext.value?.isFetching() ?? false)
    }

    public func beginBatchFetch(with context: ASBatchContext) {
        batchContext.value = context
    }

    // MARK: - ListSupplementaryViewSource

    public func supportedElementKinds() -> [String] {
        return []
    }

    public func viewForSupplementaryElement(ofKind elementKind: String,
                                            at index: Int) -> UICollectionReusableView {
        return ASIGListSupplementaryViewSourceMethods.viewForSupplementaryElement(
                ofKind: elementKind,
                at: index,
                sectionController: self
        )
    }

    public func sizeForSupplementaryView(ofKind elementKind: String,
                                         at index: Int) -> CGSize {
        return ASIGListSupplementaryViewSourceMethods.sizeForSupplementaryView(ofKind: elementKind,
                                                                               at: index)
    }

    // MARK: - ASSupplementaryNodeSource

    public func nodeBlockForSupplementaryElement(ofKind _: String,
                                                 at _: Int) -> ASCellNodeBlock {
        return ASCellNode.emptyNodeBlock
    }

    public func sizeRangeForSupplementaryElement(ofKind _: String,
                                                 at _: Int) -> ASSizeRange {
        return ASSizeRangeZero
    }

    public override func didSelectItem(at index: Int) {
        super.didSelectItem(at: index)

        didSelectIndex.onNext(Int(self.section))
    }
}
