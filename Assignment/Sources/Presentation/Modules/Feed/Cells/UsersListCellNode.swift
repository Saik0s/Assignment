//
// UsersListCellNode.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import AsyncDisplayKit

public class UsersListUserCellNode: ASCellNode {
    private enum Sizes {
        static let avatar: CGSize = CGSize(width: 30, height: 30)
    }

    private let user: UsersList.User
    private let avatar: ASNetworkImageNode = ASNetworkImageNode()
    private let title: ASTextNode = ASTextNode()
    private let bottomSeparator: ASImageNode = ASImageNode()

    public init(user: UsersList.User) {
        self.user = user
        super.init()

        automaticallyManagesSubnodes = true
        setupNodes()
    }

    private func setupNodes() {
        stylize(as: .defaultContainer)
        avatar.stylize(as: .userAvatar(URL(string: "https://api.24coms.com/demo/users/5/picture")))
        title.stylize(as: .userTitle("\(user.firstName) \(user.lastName)"))
        bottomSeparator.image = UIImage.as_resizableRoundedImage(
                withCornerRadius: 0.5,
                cornerColor: .silver,
                fill: .silver
        )
    }

    public override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let mainStack: ASStackLayoutSpec = ASStackLayoutSpec.vertical()
        let headerStack: ASStackLayoutSpec = ASStackLayoutSpec.horizontal()

        avatar.style.preferredSize = Sizes.avatar
        avatar.style.spacingAfter = 5.0

        headerStack.alignItems = .center
        headerStack.children = [avatar, title]
        headerStack.style.preferredLayoutSize = ASLayoutSizeMake(
                ASDimensionMake("100%"),
                ASDimensionMake(50)
        )

        mainStack.children = [
            ASInsetLayoutSpec(
                    insets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15),
                    child: headerStack
            ),
            bottomSeparator
        ]
        bottomSeparator.style.height = ASDimensionMake(1.0)
        mainStack.style.preferredLayoutSize = ASLayoutSizeMake(
                ASDimensionMake("100%"),
                ASDimensionMake(.auto, 0)
        )
        return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                child: mainStack
        )
    }

    public override func animateLayoutTransition(_ context: ASContextTransitioning) {
        super.animateLayoutTransition(context)
    }

    // MARK: - Main thread
    public override func didLoad() {
        super.didLoad()
    }

    public override func layout() {
        super.layout()
    }
}

extension UsersListUserCellNode: SectionCellType {
    public static var cellNodeBlock: (UsersList.User) -> ASCellNodeBlock = { model in
        { UsersListUserCellNode(user: model) }
    }
}
