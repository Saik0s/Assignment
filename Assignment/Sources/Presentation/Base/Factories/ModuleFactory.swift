//
// Created by Igor Tarasenko
//

import Foundation

public protocol ModuleFactoryType: class {
}

public class ModuleFactory: ModuleFactoryType {
    let service: UsersServiceType

    /// Injection
    public init(service: UsersServiceType = UsersService()) {
        self.service = service
    }
}

extension ModuleFactory: UsersListModuleFactoryType {
}

extension ModuleFactory: DetailsModuleFactoryType {
}
