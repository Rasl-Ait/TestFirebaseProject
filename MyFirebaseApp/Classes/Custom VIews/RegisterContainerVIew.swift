//
//  RegisterContainerVIew.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

protocol RegisterContainerVIewDelegate {
	func signUpTappedButton()
	func addImage()
	
}

final class RegisterContainerVIew: UIView {
	
	private let stackView = UIStackView()
	private let stackViewTextField = UIStackView()
	private let nameTextField = UITextField()
	private let emailTextField = UITextField()
	private let passwordTextField = UITextField()
	private let profileImageView = UIImageView()
	let signUpButton = UIButton()
	
	var delegate: RegisterContainerVIewDelegate?
	var usernameTextChanged: ItemClosure<String>?
	var emailTextChanged: ItemClosure<String>?
	var passwordTextChanged: ItemClosure<String>?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addStackView()
		addProfileImageView()
		addStackViewTExtField()
		addNameTextField()
		addEmailTextField()
		addPasswordTextField()
		addSignInButton()
		addTargets()
		
	}
	
	func set(image: UIImage?) {
		profileImageView.image = image

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
										 paddingBottom: 20,
										 paddingRight: 16,
										 width: 0, height: 0)
		
	}
	
	private func addProfileImageView() {
		profileImageView.translatesAutoresizingMaskIntoConstraints = false
		profileImageView.image = #imageLiteral(resourceName: "placeholderImg.jpeg")
		profileImageView.layer.cornerRadius = 30
		profileImageView.clipsToBounds = true
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
		emailTextField.textAlignment = .left
		emailTextField.borderStyle = .roundedRect
		emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
																															attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
		
		stackViewTextField.addArrangedSubview(emailTextField)
		
	}
	
	private func addPasswordTextField() {
		passwordTextField.borderStyle = .roundedRect
		passwordTextField.textAlignment = .left
	  //passwordTextField.isSecureTextEntry = true
		passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
																																 attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
		
		stackViewTextField.addArrangedSubview(passwordTextField)
		
	}
	
	private func addSignInButton() {
		signUpButton.setTitle("Sign Up", for: .normal)
		signUpButton.setTitleColor(#colorLiteral(red: 0.6470588235, green: 0.5607843137, blue: 0.5607843137, alpha: 1), for: .normal)
		signUpButton.isEnabled = false
		signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
		stackView.addArrangedSubview(signUpButton)
	}
	
	private func addTargets() {
		signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
		profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addImage)))
		nameTextField.addTarget(self, action: #selector(usernameTextChanged(sender:)), for: .editingChanged)
		emailTextField.addTarget(self, action: #selector(emailTextChanged(sender:)), for: .editingChanged)
		passwordTextField.addTarget(self, action: #selector(passwordTextChanged(sender:)), for: .editingChanged)
		
	}

	@objc private func usernameTextChanged(sender: UITextField) {
		usernameTextChanged?(sender.text ?? "")
	}
	
	@objc private func emailTextChanged(sender: UITextField) {
		emailTextChanged?(sender.text ?? "")
	}
	
	@objc private func passwordTextChanged(sender: UITextField) {
		passwordTextChanged?(sender.text ?? "")
	}
	
	@objc private func signUpButtonTapped() {
		delegate?.signUpTappedButton()
		
	}
	
	@objc private func addImage() {
		delegate?.addImage()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

