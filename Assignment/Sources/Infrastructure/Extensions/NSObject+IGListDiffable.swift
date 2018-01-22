//
// NSObject+IGListDiffable.swift
//
// Created by Igor Tarasenko
//

import IGListKit

extension NSObject: ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
