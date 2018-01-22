//
// DetailsModuleFactory.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import RxSwift

public protocol DetailsModuleFactoryType: class {
    func makeDetailsModule(user: UsersList.User) -> (Presentable, Observable<Void>)
}

extension DetailsModuleFactoryType
        where /* Self: ModuleFactoryType, */ Self == ModuleFactory {
    public func makeDetailsModule(user: UsersList.User) -> (Presentable, Observable<Void>) {
        let controller: DetailsController = DetailsController(user: user)

        return (controller, controller.removePressed)
    }
}
