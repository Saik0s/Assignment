//
// UsersListModuleFactory.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation

public protocol UsersListModuleFactoryType: class {
    func makeUsersListModule() -> (UsersListModuleOutput, Presentable)
}

extension UsersListModuleFactoryType
        where /* Self: ModuleFactoryType, */ Self == ModuleFactory {
    public func makeUsersListModule() -> (UsersListModuleOutput, Presentable) {
        let interactor: UsersListInteractor = UsersListInteractor(service: service)
        let presenter: UsersListPresenter = UsersListPresenter(input: interactor)
        let controller: UsersListController = UsersListController(input: presenter, factory: self)
                .then {
                    interactor.bind(input: $0)
                }

        return (interactor, controller)
    }
}
