//
//  RegisterContainerVIew.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

protocol RegisterContainerVIewDelegate {
    func signUpTappedButton(with name: String, email: String, password: String, data: Data)
    func addImage()
    
}

class RegisterContainerVIew: UIView {

    private let stackView = UIStackView()
    private let stackViewTextField = UIStackView()
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signUpButton = UIButton()
    let profileImageView = UIImageView()
    
    var delegate: RegisterContainerVIewDelegate?
    
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
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
        
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
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
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
    
    @objc private func signUpButtonTapped() {
        guard let username = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let image = profileImageView.image else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        delegate?.signUpTappedButton(with: username, email: email, password: password, data: imageData)
   
    }
    
    @objc private func addImage() {
        delegate?.addImage()
  
    }

}
