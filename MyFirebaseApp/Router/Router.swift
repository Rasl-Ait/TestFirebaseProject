//
//  Router.swift
//  MyFirebaseApp
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation

import UIKit

final class Router {
    static let shared = Router()
    
    private init() {}
    
    private let rootViewController: UIViewController = WelcomeController()
    
    func root(_ window: inout UIWindow?) {
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    }
}

