//
// DetailsController.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import AsyncDisplayKit
import RxSwift
import RxCocoa

public class DetailsController: ASViewController<DetailsNode> {
    public let removePressed: PublishSubject<Void> = PublishSubject()

    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var originalPosition: CGPoint?
    private var currentPositionTouched: CGPoint?

    public init(user: UsersList.User) {
        let node = DetailsNode(user: user)
        super.init(node: node)

        bindInput()
    }

    public required init?(coder _: NSCoder) {
        fatalError("Not Implemented")
    }

    deinit {
    }

    func bindInput() {
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        panGestureRecognizer = UIPanGestureRecognizer(
                target: self,
                action: #selector(panGestureAction(_:))
        )
        view.addGestureRecognizer(panGestureRecognizer!)

        node.removePressed.drive(removePressed)
    }

    public override func viewWillTransition(
            to size: CGSize,
            with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.node.transitionLayout(
                    with: ASSizeRange(min: size, max: size),
                    animated: true,
                    shouldMeasureAsync: true
            )
        }, completion: nil)
    }

    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)

        if panGesture.state == .began {
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(
                    x: translation.x,
                    y: translation.y
            )
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)

            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                        , animations: {
                    self.view.frame.origin = CGPoint(
                            x: self.view.frame.origin.x,
                            y: self.view.frame.size.height
                    )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
        }
    }
}

