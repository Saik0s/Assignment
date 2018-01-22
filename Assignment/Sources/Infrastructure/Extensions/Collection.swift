//
// Collection.swift
//
// Created by Igor Tarasenko
//

import Foundation

public enum IndexingError: Error {
    case invalidIndex
}

extension Collection {
    public func lookup(index: Self.Index) throws -> Self.Iterator.Element {
        guard indices.contains(index)
        else { throw IndexingError.invalidIndex }
        return self[index]
    }

    public func safeLookup(index: Self.Index) -> Self.Iterator.Element? {
        guard indices.contains(index)
        else { return nil }
        return self[index]
    }
}
