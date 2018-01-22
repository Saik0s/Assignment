//
// UsersListController.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import AsyncDisplayKit
import IGListKit
import RxSwift
import RxCocoa
import RxSwiftExt
import RxOptional
import Lottie

public protocol UsersListControllerOutput: class {
    var didSelect: PublishSubject<UsersList.Select.Request> { get }
    var didReachEnd: PublishSubject<UsersList.Users.Request> { get }
}

public class UsersListController: ASViewController<ASCollectionNode>, UsersListControllerOutput {
    public let didSelect: PublishSubject<UsersList.Select.Request> = PublishSubject()
    public let didReachEnd: PublishSubject<UsersList.Users.Request> = PublishSubject()

    private let context: Variable<ASBatchContext?> = Variable(nil)
    private let input: UsersListPresenterOutput
    private let detailsFactory: DetailsModuleFactoryType

    private var users: [UsersList.User] = []
    private lazy var spinner: LOTAnimationView = {
        let view = LOTAnimationView(name: "preloader")
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        view.contentMode = .scaleAspectFit
        view.loopAnimation = true
        view.play()
        return view
    }()
    private lazy var refresher: UIRefreshControl = {
        let control = UIRefreshControl()
        return control
    }()
    private lazy var adapter: ListAdapter = {
        ListAdapter(
                updater: ListAdapterUpdater(),
                viewController: self,
                workingRangeSize: 0
        )
    }()

    public init(input: UsersListPresenterOutput, factory: DetailsModuleFactoryType) {
        self.input = input
        self.detailsFactory = factory
        let flowLayout = UICollectionViewFlowLayout()
        let node = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: node)

        adapter.setASDKCollectionNode(node)
        adapter.dataSource = self
        bindInput()
    }

    public required init?(coder _: NSCoder) {
        fatalError("Not Implemented")
    }

    deinit {
        Logger.debug(#function)
    }

    func bindInput() {
        input.newUsers
                .subscribe(onNext: { model in
                    Logger.debug("\(model.users.count) upcoming users")
                    self.users += model.users.sorted { $0.lastName < $1.lastName }
                    self.adapter.performUpdates(animated: true)
                    self.context.value?.completeBatchFetching(true)
                    self.refresher.endRefreshing()
                }, onError: { (error: Error) in
                    let alert = UIAlertController(
                            title: "Error",
                            message: error.localizedDescription,
                            preferredStyle: UIAlertControllerStyle.alert
                    )

                    alert.addAction(
                            UIAlertAction(
                                    title: "OK",
                                    style: UIAlertActionStyle.default,
                                    handler: nil
                            )
                    )

                    self.present(alert, animated: true, completion: nil)
                })
                .disposed(by: rx.disposeBag)

        context.asObservable()
               .map({ _ in self.users.last?.id ?? 0 })
               .map({ UsersList.Users.Request(lastIndex: $0) })
               .bind(to: didReachEnd)
               .disposed(by: rx.disposeBag)

        didSelect.bind { (request: UsersList.Select.Request) in
            var (presentable, removed) = self.detailsFactory.makeDetailsModule(
                    user: self.users[request.userIndex]
            )
            self.present(
                    presentable.viewController,
                    animated: true
            )
            removed.bind { _ in
                presentable.viewController.dismiss(animated: true)
                self.users.remove(at: request.userIndex)
                self.adapter.performUpdates(animated: true)
            }.disposed(by: self.rx.disposeBag)
        }.disposed(by: rx.disposeBag)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        node.view.alwaysBounceVertical = true
        refresher.rx.controlEvent(.valueChanged)
                    .do(onNext: { _ in self.users.removeAll() })
                    .map({ UsersList.Users.Request(lastIndex: 0) })
                    .bind(to: didReachEnd)
                    .disposed(by: rx.disposeBag)
        node.view.addSubview(refresher)

        didReachEnd.onNext(UsersList.Users.Request(lastIndex: 0))
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
}

extension UsersListController: ListAdapterDataSource {
    public func listAdapter(
            _ listAdapter: ListAdapter,
            sectionControllerFor object: Any
    ) -> ListSectionController {
        let section = UsersListSectionController()
        section.onUpdateContext
                .bind(to: context)
                .disposed(by: rx.disposeBag)
        section.onSelectIndex
                .map({ UsersList.Select.Request(userIndex: $0) })
                .bind(to: didSelect)
                .disposed(by: rx.disposeBag)
        return section
    }

    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return users.diffable()
    }

    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return spinner
    }
}
