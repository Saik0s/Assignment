//
// User.swift
// Created by Igor Tarasenko on 21/01/18.
// Copyright © 2018 Igor Tarasenko
// Licensed under the MIT license, see LICENSE.md file
//

import Foundation

public protocol UserType {
    var userID: Int { get }
    var firstname: String { get }
    var insertion: String { get }
    var lastname: String { get }
    var givenname: String { get }
    var city: String { get }
    var country: String { get }
    var streetname: String { get }
    var housenumber: Int { get }
    var housenumbersuffix: String { get }
    var zipcode: String { get }
    var companyname: String { get }
    var function: String { get }
    var phonenumber: String { get }
    var mobilenumber: String { get }
    var username: String { get }
    var sex: String { get }
    var expertise: String { get }
    var institution: String { get }
    var title: String { get }
    var backgroundDescription: String { get }
}

public struct User: UserType, Codable {
    public let userID: Int
    public let firstname: String
    public let insertion: String
    public let lastname: String
    public let givenname: String
    public let city: String
    public let country: String
    public let streetname: String
    public let housenumber: Int
    public let housenumbersuffix: String
    public let zipcode: String
    public let companyname: String
    public let function: String
    public let phonenumber: String
    public let mobilenumber: String
    public let username: String
    public let sex: String
    public let expertise: String
    public let institution: String
    public let title: String
    public let backgroundDescription: String
}
