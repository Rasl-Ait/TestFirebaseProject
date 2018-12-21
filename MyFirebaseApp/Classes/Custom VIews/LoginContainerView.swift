//
//  LoginContainerView.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

protocol LoginContainerViewDelegate {
	func signInTappedButton()
	
}

class LoginContainerView: UIView {
	
	private let stackView = UIStackView()
	private let stackViewTextField = UIStackView()
	private let emailTextField = UITextField()
	private let passwordTextField = UITextField()
	let signInButton = UIButton()
	
	var delegate: LoginContainerViewDelegate?
	
	var emailTextChanged: ItemClosure<String>?
	var passwordTextChanged: ItemClosure<String>?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addStackView()
		addStackViewTExtField()
		addSignInButton()
		addEmailTextField()
		addPasswordTextField()
		addTargets()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addStackView() {
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .center
		stackView.spacing = 40
		addSubview(stackView)
		
		stackView.anchor(top: topAnchor,
										 left: leftAnchor,
										 bottom: bottomAnchor,
										 right: rightAnchor,
										 paddingTop: 0,
										 paddingLeft: 16,
										 paddingBottom: 0,
										 paddingRight: 16,
										 width: 0, height: 0)
		
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
	
	private func addEmailTextField() {
		emailTextField.textAlignment = .left
		emailTextField.borderStyle = .roundedRect
		emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
																															attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
		
		stackViewTextField.addArrangedSubview(emailTextField)
		
	}
	
	private func addPasswordTextField() {
		passwordTextField.borderStyle = .roundedRect
		passwordTextField.textAlignment = .left
		passwordTextField.isSecureTextEntry = true
		passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
																																 attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
		
		stackViewTextField.addArrangedSubview(passwordTextField)
		
	}
	
	private func addSignInButton() {
		signInButton.setTitle("Sign In", for: .normal)
		signInButton.setTitleColor(#colorLiteral(red: 0.6470588235, green: 0.5607843137, blue: 0.5607843137, alpha: 1), for: .normal)
		signInButton.isEnabled = false
		signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
		stackView.addArrangedSubview(signInButton)
	}
	
	func addTargets() {
		signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
		emailTextField.addTarget(self, action: #selector(emailTextChanged(sender:)), for: .editingChanged)
		passwordTextField.addTarget(self, action: #selector(passwordTextChanged(sender:)), for: .editingChanged)
		
	}
	
	@objc private func emailTextChanged(sender: UITextField) {
		emailTextChanged?(sender.text ?? "")
	}
	
	@objc private func passwordTextChanged(sender: UITextField) {
		passwordTextChanged?(sender.text ?? "")
	}
	
	@objc private func signInButtonTapped() {
		delegate?.signInTappedButton()
		
	}
}
