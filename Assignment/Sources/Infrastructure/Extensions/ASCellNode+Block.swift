//
// ASCellNode+Block.swift
//
// Created by Igor Tarasenko
//

import AsyncDisplayKit

extension ASCellNode {
    public static var emptyNodeBlock: ASCellNodeBlock {
        return {
            ASCellNode()
        }
    }
}
