//
// UsersService.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation
import RxSwift
import RxAlamofire

public protocol UsersServiceType {
    func getUpcomingUsersFrom(index: Int) -> Observable<[UserType]>
}

public final class UsersService: UsersServiceType {
    private struct UsersResponse: Codable {
        let items: [User]
    }

    public init() {
    }

    public func getUpcomingUsersFrom(index: Int) -> Observable<[UserType]> {
        // TODO: Remove for pagination
        guard index == 0
        else {
            return Observable.of([]).observeOn(MainScheduler.instance)
        }

        let decoder = JSONDecoder()
        return request(.get, "https://api.24coms.com/demo/users")
                .flatMap { request in
                    return request.validate(statusCode: 200 ..< 300)
                                  .validate(contentType: ["application/json"])
                            .rx.data()
                }
                .observeOn(MainScheduler.instance)
                .map { (data: Data) -> UsersResponse? in
                    do {
                        return try decoder.decode(
                                UsersResponse.self,
                                from: data
                        )
                    }
                    catch {
                        Logger.error(error)
                        return nil
                    }
                }.map { $0?.items ?? [] }
    }
}
