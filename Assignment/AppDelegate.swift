//
//  AppDelegate.swift
//  UsersListExample
//
//  Created by Igor Tarasenko on 11/12/17.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        let factory = ModuleFactory()
        window = UIWindow()
        let (_, presentable) = factory.makeUsersListModule()
        window?.rootViewController = presentable.viewController
        window?.makeKeyAndVisible()
        return true
    }
}

