//
//  WelcomeController.swift
//  MyAppTest
//
//  Created by rasl on 02.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class WelcomeController: UIViewController {
    
    private let signUpBuuton = UIButton()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let stackViewButton = UIStackView()
    private let signInLabel = UILabel()
    private let emailButton = UIButton()
    private let facebookButton = UIButton()
    private let googleButton = UIButton()
    
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
            //showToTabBarVC()
            
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: - Actions
    
    @objc private func emailButtonTapped() {
        StartRouter.shared.goTologinScreen(from: self)
    }
    
    @objc private func facebookButtonTapped() {
        showFasebookSignIn()
    }
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    @objc func signUpBuutonTapped() {
        StartRouter.shared.goToRegisterScreen(from: self)
        
    }
}

// MARK: - private extension WelcomeController

private extension WelcomeController {
    private func initialized() {
        view.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
        delegateGoogle()
        addSignInBuuton()
        addTitleLabel()
        addStackView()
        addSignInLabel()
        addStackViewBitton()
        addEmailButton()
        addFaceBookButton()
        addGoogleButton()
        addTargets()
        
    }
    private func addEmailButton() {
        emailButton.setImage(UIImage(named: "email" ), for: .normal)
        
        stackViewButton.addArrangedSubview(emailButton)
    }
    
    private func addFaceBookButton() {
        facebookButton.setImage(UIImage(named: "facebook" ), for: .normal)
        stackViewButton.addArrangedSubview(facebookButton)
        
    }
    
    private func addGoogleButton() {
        googleButton.setImage(UIImage(named: "google" ), for: .normal)
        stackViewButton.addArrangedSubview(googleButton)
        
    }
    
    private func addTargets(){
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        signUpBuuton.addTarget(self, action: #selector(signUpBuutonTapped), for: .touchUpInside)
        
        
    }
    
    private func addSignInLabel() {
        signInLabel.text = "Sign In"
        signInLabel.font = UIFont.boldSystemFont(ofSize: 20)
        signInLabel.textColor = #colorLiteral(red: 0.9568627451, green: 0.937254902, blue: 0.937254902, alpha: 1)
        stackView.addArrangedSubview(signInLabel)
        
    }
    
    private func addStackViewBitton() {
        stackViewButton.axis = .horizontal
        stackViewButton.alignment = .fill
        stackViewButton.distribution = .fill
        stackViewButton.spacing = 20
        stackView.addArrangedSubview(stackViewButton)
        
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
    
    private func addStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 50
        view.addSubview(stackView)
        
        stackView.anchor(top: titleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: nil,
                         right: view.rightAnchor,
                         paddingTop: 250,
                         paddingLeft: 16,
                         paddingBottom: 20,
                         paddingRight: 16,
                         width: 0, height: 0)
        
        
    }
    
    private func addSignInBuuton() {
        signUpBuuton.setTitle("Don’t have an account?", for: .normal)
        signUpBuuton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(signUpBuuton)
        
        signUpBuuton.anchor(top: nil,
                            left: view.leftAnchor,
                            bottom: view.bottomAnchor,
                            right: view.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 16,
                            paddingBottom: 20,
                            paddingRight: 16,
                            width: 0, height: 0)
        
        
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
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // self.showToTabBarVC()
            }
        }
    }
    
    private func loginWithGoogle(authentication: GIDAuthentication) {
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            self.showToTabBarVC()
            
        }
    }
    
    // MARK: - Navigation metchod
    
    private func showToTabBarVC() {
        self.performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
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

