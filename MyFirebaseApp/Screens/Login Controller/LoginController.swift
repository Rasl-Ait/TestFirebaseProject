//
//  LoginController.swift
//  MyFirebaseApp
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    lazy var containerView: LoginContainerView = {
        let view = LoginContainerView()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialized()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

private extension LoginController {
    private func initialized() {
        title = "Login"
        view.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
        addContainerView()
       
    }
    
    private func addContainerView() {
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor,
                             left: view.leftAnchor,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 150,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0, height: 0)
        
    }
}

// MARK: - LoginContainerViewDelegate

extension LoginController: LoginContainerViewDelegate {
    func signInTappedButton(with email: String, password: String) {
        AuthService.signIn(email: email, password: password, onSuccess: {
            ProgressHUD.showSuccess("Success")
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarController else { return }
            mainTabBarController.setupViewControllers()
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            ProgressHUD.showError(error!)
            
        }
    }
}
