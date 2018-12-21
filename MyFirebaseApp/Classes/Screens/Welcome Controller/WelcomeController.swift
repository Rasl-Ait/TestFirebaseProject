//
//  WelcomeController.swift
//  MyFirebaseApp
//
//  Created by rasl on 02.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class WelcomeController: UIViewController {
	
	private let titleLabel = UILabel()
	
	lazy var containerView: WelcomeContainerView = {
		let view = WelcomeContainerView()
		view.delegate = self
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialized()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		if Auth.auth().currentUser != nil {
			StartRouter.shared.goToTabBarScrenn(from: self)
			
		}
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
}

// MARK: - private extension WelcomeController

private extension WelcomeController {
	private func initialized() {
		view.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
		delegateGoogle()
		addTitleLabel()
		addContainerView()
		
	}
	
	private func addContainerView() {
		view.addSubview(containerView)
		containerView.anchor(top: titleLabel.topAnchor,
												 left: view.leftAnchor,
												 bottom: nil,
												 right: view.rightAnchor,
												 paddingTop: 250,
												 paddingLeft: 0,
												 paddingBottom: 0,
												 paddingRight: 0,
												 width: 0, height: 0)
		
	}
	
	
	private func addTitleLabel() {
		titleLabel.text = "My App"
		titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
		titleLabel.textColor = #colorLiteral(red: 0.9568627451, green: 0.937254902, blue: 0.937254902, alpha: 1)
		titleLabel.textAlignment = .center
		view.addSubview(titleLabel)
		
		titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor,
											bottom: nil,
											right: view.rightAnchor, paddingTop: 100,
											paddingLeft: 20, paddingBottom: 0,
											paddingRight: 20, width: 0, height: 0)
		
		
	}
	
	private func delegateGoogle() {
		GIDSignIn.sharedInstance().delegate = self
		GIDSignIn.sharedInstance().uiDelegate = self
	}
	
	// MARK: - Button metchod
	
	private func showFasebookSignIn() {
		let fbloginManager = FBSDKLoginManager()
		fbloginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
			if let error = error {
				print("Failed to login: \(error.localizedDescription)")
				return
			}
			
			guard let accessToken = FBSDKAccessToken.current() else {
				print("Failed to get access token")
				return
			}
			
			let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
			
			Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
				if let error = error {
					print("Login error: \(error.localizedDescription)")
					let alertController = UIAlertController(title: "Login Error",
																									message: error.localizedDescription,
																									preferredStyle: .alert)
					let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
					alertController.addAction(okayAction)
					self.present(alertController, animated: true, completion: nil)
					
					return
				}
				
				StartRouter.shared.goToTabBarScrenn(from: self)
			}
		}
	}
	
	private func loginWithGoogle(authentication: GIDAuthentication) {
		let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
																									 accessToken: authentication.accessToken)
		
		Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
			if let error = error {
				print("Login error: \(error.localizedDescription)")
				let alertController = UIAlertController(title: "Login Error",
																								message: error.localizedDescription,
																								preferredStyle: .alert)
				let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
				alertController.addAction(okayAction)
				self.present(alertController, animated: true, completion: nil)
				
				return
			}
			
			StartRouter.shared.goToTabBarScrenn(from: self)
			
		}
	}
}

// MARK: - extension WelcomeController

extension WelcomeController {
	@IBAction func cancelWelcomeSegue(_ segue: UIStoryboardSegue) {}
}

// MARK: - GIDSignInDelegate

extension WelcomeController: GIDSignInDelegate, GIDSignInUIDelegate {
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		
		if let error = error {
			print(error.localizedDescription)
			return
		}
		
		loginWithGoogle(authentication: user.authentication)
	}
	
	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
		
	}
}

// MARK: - WelcomeContainerViewDelegate

extension WelcomeController: WelcomeContainerViewDelegate {
	func emailTappedButton() {
		StartRouter.shared.goTologinScreen(from: self)
	}
	
	func facebookTappedButton() {
		showFasebookSignIn()
	}
	
	func googleTappedButton() {
		GIDSignIn.sharedInstance().signIn()
		
	}
}
