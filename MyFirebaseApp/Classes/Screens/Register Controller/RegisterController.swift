//
//  RegisterController.swift
//  MyFirebaseApp
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit
import ARSLineProgress

class RegisterController: UIViewController {
	
	private let userModel = RegisterModel()
	private var selectedImage: UIImage?
	private let button = UIButton()
	
	lazy var containerView: RegisterContainerVIew = {
		let view = RegisterContainerVIew()
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
		StartRouter.shared.goTologinScreen(from: self)
		
	}
}

private extension RegisterController {
	private func initialized() {
		title = "Registration"
		view.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
		addContainerView()
		addButton()
		addTargets()
		saveUserModel()
		
	}
	
	private func updateDoneButtonStatus() {
		containerView.signUpButton.isEnabled = userModel.isFilled
		if userModel.isFilled {
			containerView.signUpButton.setTitleColor(#colorLiteral(red: 0.9568627451, green: 0.937254902, blue: 0.937254902, alpha: 1), for: .normal)
		}
	}
	
	private func saveUserModel() {
		containerView.usernameTextChanged = { text in
			self.userModel.username = text
			self.updateDoneButtonStatus()
		}
		containerView.emailTextChanged = { text in
			self.userModel.email = text
			self.updateDoneButtonStatus()
		}
		containerView.passwordTextChanged = { text in
			self.userModel.password = text
			self.updateDoneButtonStatus()
		}
	}
	
	private func addContainerView() {
		view.addSubview(containerView)
		containerView.anchor(top: view.topAnchor, left: view.leftAnchor,  bottom: nil,
												 right: view.rightAnchor, paddingTop: 150, paddingLeft: 0,
												 paddingBottom: 0, paddingRight: 0,  width: 0, height: 0)
		
	}
	
	private func addTargets(){
		button.addTarget(self, action: #selector(buutonTapped), for: .touchUpInside)
		
	}
	
	private func addButton() {
		let attributedText = NSMutableAttributedString(string: "Already have an account? ",
																									 attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
																																NSAttributedString.Key.foregroundColor: UIColor.lightGray])
		attributedText.append(NSAttributedString(string: "Sign In",
																						 attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
																													NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9570000172, green: 0.9369999766, blue: 0.9369999766, alpha: 1)]))
		attributedText.append(NSAttributedString(string: ".",
																						 attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
																													NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
		button.setAttributedTitle(attributedText, for: .normal)
		view.addSubview(button)
		
		button.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor,
									right: view.rightAnchor, 	paddingTop: 0, paddingLeft: 16,
									paddingBottom: 20, paddingRight: 16, width: 0, height: 0)
		
		
	}
}

extension RegisterController: RegisterContainerVIewDelegate {
	func signUpTappedButton() {
		view.endEditing(true)
		ProgressHUD.show("Waiting...")
		AuthService.register(with: userModel) { result in
			switch result {
			case .success(_):
				ProgressHUD.showSuccess("Success")
				StartRouter.shared.goToTabBarScrenn(from: self)
			case .failure(let error):
				ProgressHUD.showError(error.localizedDescription)
			}
		}
	}
	
	func addImage() {
		let pickerController = UIImagePickerController()
		pickerController.delegate = self
		pickerController.sourceType = .photoLibrary
		present(pickerController, animated: true, completion: nil)
	}
}

// MARK: -  UIImagePickerControllerDelegate

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
			return
		}
		
		picker.dismiss(animated: true, completion: nil)
		userModel.profileImageUrl = image
		containerView.set(image: userModel.profileImageUrl)
		
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
		
	}
}

