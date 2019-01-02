//
//  ButtonView.swift
//  MyFirebaseApp
//
//  Created by rasl on 23.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class ButtonView: UIView {
	private let saveButton = UIButton()
	private let logOutButton = UIButton()
	private let separateView = UIView()
	
	var saveButtonClicked: VoidClosure?
	var logOutButtonClicked: VoidClosure?
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		Decorator.decorate(self)
		addSaveButton()
		addSeparateView()
		addLogOutButton()
		addTargets()
		
	}
	

	private func addTargets() {
		saveButton.addTarget(self, action: #selector(savebuttonTapped(sender:)), for: .touchUpInside)
		logOutButton.addTarget(self, action: #selector(logOutButton(sender:)), for: .touchUpInside)
	}
	
	@objc private func savebuttonTapped(sender: UIButton) {
		saveButtonClicked?()
	}
	
	@objc private func logOutButton(sender: UIButton) {
		logOutButtonClicked?()
	}
	
	private func addSaveButton () {
	  saveButton.setTitle("Save", for: .normal)
		saveButton.setTitleColor(.black, for: .normal)
		saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		addSubview(saveButton)
		
		
		saveButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil,
												 right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0,
												 paddingRight: 0, width: 0, height: 0)
		
	}
	
	private func addSeparateView() {
		separateView.translatesAutoresizingMaskIntoConstraints = false
		separateView.backgroundColor = #colorLiteral(red: 0.7450000048, green: 0.7450000048, blue: 0.7450000048, alpha: 1)
		addSubview(separateView)
		
		separateView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		separateView.topAnchor.constraint(equalTo: saveButton.bottomAnchor).isActive = true
		separateView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		separateView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		separateView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
		
	}
	
	private func addLogOutButton() {
		logOutButton.setTitle("Log Out", for: .normal)
		logOutButton.setTitleColor(.red, for: .normal)
		logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		addSubview(logOutButton)
		
		logOutButton.anchor(top: separateView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor,
													right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0,
													paddingRight: 0, width: 0, height: 0)
		
	}
}

extension ButtonView {
	fileprivate final class Decorator {
		static func decorate(_ view: ButtonView) {
			view.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
			view.layer.borderWidth = 1
			view.backgroundColor = .white
		}
	}
}
