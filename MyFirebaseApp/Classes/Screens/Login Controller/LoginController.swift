//
//  LoginController.swift
//  MyFirebaseApp
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit
import ARSLineProgress

class LoginController: UIViewController {
	
	private let button = UIButton()
	private let authModel = AuthModel()
	
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
	
	// MARK: - Actions
	
	@objc func buutonTapped() {
		StartRouter.shared.goToRegisterScreen(from: self)
		
	}
}

private extension LoginController {
	private func initialized() {
		title = "Login"
		view.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
		addContainerView()
		addButton()
		addTargets()
		authUserModel()
		
	}
	
	private func updateDoneButtonStatus() {
		containerView.signInButton.isEnabled = authModel.isFilled
		if authModel.isFilled {
			containerView.signInButton.setTitleColor(#colorLiteral(red: 0.9568627451, green: 0.937254902, blue: 0.937254902, alpha: 1), for: .normal)
		}
	}
	
	private func authUserModel() {
		containerView.emailTextChanged = { text in
			self.authModel.email = text
			self.updateDoneButtonStatus()
		}
		containerView.passwordTextChanged = { text in
			self.authModel.password = text
			self.updateDoneButtonStatus()
		}
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
	
	private func addTargets(){
		button.addTarget(self, action: #selector(buutonTapped), for: .touchUpInside)
		
	}
	
	private func addButton() {
		let attributedText = NSMutableAttributedString(string: "Don’t have an account?",
																									 attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
																																NSAttributedString.Key.foregroundColor: UIColor.lightGray])
		attributedText.append(NSAttributedString(string: "Sign Up",
																						 attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
																													NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9570000172, green: 0.9369999766, blue: 0.9369999766, alpha: 1)]))
		attributedText.append(NSAttributedString(string: ".",
																						 attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
																													NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
		button.setAttributedTitle(attributedText, for: .normal)
		view.addSubview(button)
		
		button.anchor(top: nil,
									left: view.leftAnchor,
									bottom: view.bottomAnchor,
									right: view.rightAnchor,
									paddingTop: 0,
									paddingLeft: 16,
									paddingBottom: 20,
									paddingRight: 16,
									width: 0, height: 0)
		
		
	}
}

// MARK: - LoginContainerViewDelegate

extension LoginController: LoginContainerViewDelegate {
	func signInTappedButton() {
		view.endEditing(true)
		ProgressHUD.show("Waiting...")
		AuthService.signIn(with: authModel) { result in
			switch result {
			case .success:
			ProgressHUD.showSuccess("Success")
				StartRouter.shared.goToTabBarScrenn(from: self)
			case .error(let error):
					ProgressHUD.showError(error)
			}
		}
	}
}
