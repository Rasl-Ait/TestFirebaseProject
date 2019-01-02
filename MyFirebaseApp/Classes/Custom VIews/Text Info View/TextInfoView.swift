//
//  TextInfoView.swift
//  MyFirebaseApp
//
//  Created by rasl on 22.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

final class TextInfoView: UIView {
	
	private let nameTextField = UITextField()
	private let emailTextField = UITextField()
	private let separateView = UIView()
	
	var usernameTextChanged: ItemClosure<String>?
	var emailTextChanged: ItemClosure<String>?
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		Decorator.decorate(self)
		addNameTextField()
		addSeparateView()
		addEmailTextField()
		addTargets()
		
	}
	
	func set(with name: String?, email: String?) {
		nameTextField.text = name
		emailTextField.text = email
	}
	
	private func addNameTextField() {
		nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
																														 attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
		nameTextField.font = UIFont.systemFont(ofSize: 15)
		nameTextField.textAlignment = .left
		nameTextField.borderStyle = .none
		addSubview(nameTextField)
		
		nameTextField.anchor(top: topAnchor, left: leftAnchor, bottom: nil,
												 right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0,
												 paddingRight: 0, width: 0, height: 0)
		
	}
	
	private func addSeparateView() {
		separateView.translatesAutoresizingMaskIntoConstraints = false
		separateView.backgroundColor = #colorLiteral(red: 0.7450000048, green: 0.7450000048, blue: 0.7450000048, alpha: 1)
		addSubview(separateView)
		
		separateView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		separateView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		separateView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		separateView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		separateView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
		
	}
	
	private func addEmailTextField() {
		emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
																															attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
		emailTextField.font = UIFont.systemFont(ofSize: 15)
		emailTextField.textAlignment = .left
		emailTextField.borderStyle = .none
		addSubview(emailTextField)
		
		emailTextField.anchor(top: separateView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor,
													right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0,
													paddingRight: 0, width: 0, height: 0)
		
	}
	
	private func addTargets() {
		nameTextField.addTarget(self, action: #selector(usernameTextChanged(sender:)), for: .editingChanged)
		emailTextField.addTarget(self, action: #selector(emailTextChanged(sender:)), for: .editingChanged)
		
	}
	
	@objc private func usernameTextChanged(sender: UITextField) {
		usernameTextChanged?(sender.text ?? "")
	}
	
	@objc private func emailTextChanged(sender: UITextField) {
		emailTextChanged?(sender.text ?? "")
	}
}

extension TextInfoView {
	fileprivate final class Decorator {
		static func decorate(_ view: TextInfoView) {
			view.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
			view.layer.borderWidth = 1
			view.backgroundColor = .white
		}
	}
}


