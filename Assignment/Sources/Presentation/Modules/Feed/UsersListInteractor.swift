//
// UsersListInteractor.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import RxSwift
import RxCocoa

public protocol UsersListInteractorOutput {
    var users: PublishSubject<UsersList.Users.Response> { get }
}

public protocol UsersListInteractorDataStore {
}

public protocol UsersListModuleOutput {
    var onDidSelect: PublishSubject<Int> { get }
}

public class UsersListInteractor: UsersListInteractorOutput {
    public typealias Dependency = UsersServiceType

    public let users: PublishSubject<UsersList.Users.Response> = PublishSubject()
    public let onDidSelect: PublishSubject<Int> = PublishSubject()

    private weak var input: UsersListControllerOutput?

    private let service: Dependency
    private let bag: DisposeBag = DisposeBag()

    init(service: Dependency) {
        self.service = service
    }

    deinit {
        Logger.debug(#function)
    }

    func bind(input: UsersListControllerOutput) {
        guard self.input == nil
        else { preconditionFailure("Did set input multiple times") }
        self.input = input

        input.didReachEnd
                .flatMapLatest({ request in
                    self.service.getUpcomingUsersFrom(index: request.lastIndex)
                })
                .map({ UsersList.Users.Response(userObjects: $0) })
                .bind(to: users)
                .disposed(by: bag)

        input.didSelect
                .map({ $0.userIndex })
                .bind(to: onDidSelect)
                .disposed(by: bag)
    }
}

extension UsersListInteractor: InteractorType {
}

extension UsersListInteractor: UsersListInteractorDataStore {
}

extension UsersListInteractor: UsersListModuleOutput {
}
