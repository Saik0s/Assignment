//
// UsersListPresenter.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import RxSwift
import RxCocoa

public protocol UsersListPresenterOutput {
    var newUsers: PublishSubject<UsersList.Users.ViewModel> { get }
}

public class UsersListPresenter: UsersListPresenterOutput {
    public var newUsers: PublishSubject<UsersList.Users.ViewModel> = PublishSubject()

    private let input: UsersListInteractorOutput
    private let bag: DisposeBag = DisposeBag()

    init(input: UsersListInteractorOutput) {
        self.input = input

        bindInputs()
    }

    deinit {
        Logger.debug(#function)
    }

    func bindInputs() {
        input.users
                .map { response in
                    let users = response.userObjects.map {
                        UsersList.User(
                                userID: "\($0.userID)",
                                firstName: $0.firstname,
                                lastName: $0.lastname,
                                city: $0.city,
                                country: $0.country,
                                streetName: $0.streetname,
                                houseNumber: "\($0.housenumber)",
                                username: $0.username,
                                sex: $0.sex
                        )
                    }
                    return UsersList.Users.ViewModel(users: users)
                }
                .bind(to: newUsers)
                .disposed(by: bag)
    }
}
