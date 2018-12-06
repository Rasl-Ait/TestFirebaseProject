//
//  RegisterController.swift
//  MyAppTest
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    
    private let stackView = UIStackView()
    private let stackViewTextField = UIStackView()
    private let profileImageView = UIImageView()
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signUpButton = UIButton()
    
    
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

private extension RegisterController {
    private func initialized() {
        title = "Login"
        view.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
        addStackView()
        addProfileImageView()
        addStackViewTExtField()
        addNameTextField()
        addEmailTextField()
        addPasswordTextField()
        addSignInButton()
        addTargets()
        
        
    }
    
    private func addStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 40
        view.addSubview(stackView)
        
        stackView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: nil,
                         right: view.rightAnchor,
                         paddingTop: 200,
                         paddingLeft: 16,
                         paddingBottom: 0,
                         paddingRight: 16,
                         width: 0, height: 0)
        
    }
    
    private func addProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = #imageLiteral(resourceName: "placeholderImg.jpeg")
        profileImageView.isUserInteractionEnabled = true
        stackView.addArrangedSubview(profileImageView)
        
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    
    private func addStackViewTExtField() {
        stackViewTextField.axis = .vertical
        stackViewTextField.distribution = .fill
        stackViewTextField.alignment = .fill
        stackViewTextField.spacing = 20
        stackViewTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(stackViewTextField)
        
        stackViewTextField.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        stackViewTextField.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        
        
    }
    
    private func addNameTextField() {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "name",
                                                                attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
        nameTextField.textAlignment = .left
        nameTextField.borderStyle = .roundedRect
        stackViewTextField.addArrangedSubview(nameTextField)
        
    }
    
    private func addEmailTextField() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
        emailTextField.textAlignment = .left
        emailTextField.borderStyle = .roundedRect
        stackViewTextField.addArrangedSubview(emailTextField)
        
    }
    
    private func addPasswordTextField() {
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
        passwordTextField.textAlignment = .left
        stackViewTextField.addArrangedSubview(passwordTextField)
        
    }
    
    private func addSignInButton() {
        signUpButton.setTitle("Sign Un", for: .normal)
        signUpButton.setTitleColor(#colorLiteral(red: 0.6470588235, green: 0.5607843137, blue: 0.5607843137, alpha: 1), for: .normal)
        signUpButton.isEnabled = false
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        stackView.addArrangedSubview(signUpButton)
    }
    
    private func addTargets() {
        signUpButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addImage)))
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)

    }
    
    @objc func textFieldDidChange() {
        guard  let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                signUpButton.setTitleColor(#colorLiteral(red: 0.6470588235, green: 0.5607843137, blue: 0.5607843137, alpha: 1), for: .normal)
                signUpButton.isEnabled = false
                return
        }
        
        signUpButton.setTitleColor(#colorLiteral(red: 0.9568627451, green: 0.937254902, blue: 0.937254902, alpha: 1), for: .normal)
        signUpButton.isEnabled = true
    }
    
    @objc private func signInButtonTapped() {
        print("s")
    }
    
    @objc private func addImage() {
        print("image")
    }
}

