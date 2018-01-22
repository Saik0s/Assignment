// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import IGListKit

/**
 A diffable value type that can be used in conjunction with
 `DiffUtility` to perform a diff between two result sets.
 */
public protocol Diffable: Equatable {
    /**
     Returns a key that uniquely identifies the object.

     - returns: A key that can be used to uniquely identify the object.

     - note: Two objects may share the same identifier, but are not equal.

     - warning: This value should never be mutated.
     */
    var diffIdentifier: String { get }
}

public final class DiffableBox<T: Diffable>: ListDiffable {
    let value: T
    let identifier: NSObjectProtocol
    let equal: (T, T) -> Bool

    init(
            value: T,
            identifier: NSObjectProtocol,
            equal: @escaping (T, T) -> Bool
    ) {
        self.value = value
        self.identifier = identifier
        self.equal = equal
    }

    // ListDiffable
    public func diffIdentifier() -> NSObjectProtocol {
        return identifier
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let other = object as? DiffableBox<T> {
            return equal(value, other.value)
        }
        return false
    }
}

extension String: Diffable {
    public var diffIdentifier: String {
        return self
    }
}

extension Int: Diffable {
    public var diffIdentifier: String {
        return String(self)
    }
}

extension Sequence where Iterator.Element: Diffable {
    public func diffable() -> [ListDiffable] {
        let toListDiffable: [ListDiffable] = map { listDiffable in
            DiffableBox(
                    value: listDiffable,
                    identifier: listDiffable.diffIdentifier as NSObjectProtocol,
                    equal: ==
            )
        }
        return toListDiffable
    }
}
