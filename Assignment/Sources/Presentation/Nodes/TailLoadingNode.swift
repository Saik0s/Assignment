//
// TailLoadingNode.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import AsyncDisplayKit.ASCellNode
import AsyncDisplayKit.ASDisplayNode

/**
 *  TailLoadingNode
 *
 *  ````
 *  ````
*/
final public class TailLoadingNode: ASCellNode {
    private let activityIndicatorNode: ASDisplayNode

    public override init() {
        activityIndicatorNode = ASDisplayNode { () -> UIView in
            let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            view.startAnimating()
            return view
        }
        super.init()
        style.height = ASDimensionMake(100)
    }

    public override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        return ASCenterLayoutSpec(
                centeringOptions: .XY,
                sizingOptions: .minimumXY,
                child: activityIndicatorNode
        )
    }
}
