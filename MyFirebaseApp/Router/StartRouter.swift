//
//  StartRouter.swift
//  VKApp
//
//  Created by rasl on 03.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

final class StartRouter {
    static let shared = StartRouter()
    
    private init() {}
    
    func goToRegisterScreen(from source: UIViewController) {
        let vc = RegisterController()
        source.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goTologinScreen(from source: UIViewController) {
        let vc = LoginController()
        source.navigationController?.pushViewController(vc, animated: true)
    }
}
