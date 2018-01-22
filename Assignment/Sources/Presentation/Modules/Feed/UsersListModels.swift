//
// UsersListModels.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import RxSwift
import RxCocoa

public enum UsersList {
    public struct User: AutoEquatable, AutoListDiffable {
        public var id: Int { return Int(userID) ?? 0 }
        public let userID: String
        public let firstName: String
        public let lastName: String
        public let city: String
        public let country: String
        public let streetName: String
        public let houseNumber: String
        public let username: String
        public let sex: String
    }

    public struct SectionModel: AutoEquatable {
        public var users: [UsersList.User] = []
        public var lastIndex: Int = 0
        // sourcery: skipEquality
        public var busy: Variable<Bool> = Variable(false)
        public var didReachEnd: Bool = false

        public var diffIdentifier: String {
            return users.reduce("") { "\($0)\($1.id)" }
        }
    }

    public enum Users {
        public struct Request {
            let lastIndex: Int
        }

        public struct Response {
            let userObjects: [UserType]
        }

        public struct ViewModel {
            let users: [UsersList.User]
        }
    }

    public enum Select {
        public struct Request {
            let userIndex: Int
        }

        public struct Response {
        }

        public struct ViewModel {
        }
    }
}

// MARK: - UsersList.User AutoEquatable
extension UsersList.User: Equatable {
}

public func ==(lhs: UsersList.User, rhs: UsersList.User) -> Bool {
    guard lhs.id == rhs.id
    else { return false }
    return true
}

// MARK: - UsersList.SectionModel AutoEquatable
extension UsersList.SectionModel: Equatable {
}

public func ==(lhs: UsersList.SectionModel, rhs: UsersList.SectionModel) -> Bool {
    guard lhs.users == rhs.users
    else { return false }
    guard lhs.lastIndex == rhs.lastIndex
    else { return false }
    guard lhs.didReachEnd == rhs.didReachEnd
    else { return false }
    return true
}
