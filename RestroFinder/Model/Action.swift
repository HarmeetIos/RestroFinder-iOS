//
//  Action.swift
//  RestroFinder
//
//  Created by Harmeet Singh on 2021-07-30.
//  Copyright © 2021 Harmeet Singh. All rights reserved.
//

import UIKit

/// Class for managing login and logout flow
class Action {
    private init() {}
    fileprivate static let loginControllerIdentifier = "SignInNavController"
    fileprivate static let homeControllerIdentifier = "TabBarController"
}


class ActionShowLogin: Action {
    static func execute() {
        SceneDelegate.shared?.window?.rootViewController = UIStoryboard.main.instantiateViewController(withIdentifier: loginControllerIdentifier)
    }
}

class ActionShowHome: Action {
    static func execute() {
        SceneDelegate.shared?.window?.rootViewController = UIStoryboard.main.instantiateViewController(withIdentifier: homeControllerIdentifier)
    }
}
