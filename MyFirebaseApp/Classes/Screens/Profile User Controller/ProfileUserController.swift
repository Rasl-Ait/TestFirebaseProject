//
//  ProfileUserController.swift
//  MyFirebaseApp
//
//  Created by rasl on 20.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class ProfileUserController: UIViewController {
	
	private let tableView = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialized()
		
	}
}

private extension ProfileUserController {
	func initialized() {
		view.backgroundColor = .white
		addRightBarButton()
	}
	
	private func addRightBarButton() {
		let barButton = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(barButtonTapped(sender:)))
		navigationItem.rightBarButtonItem = barButton
	
	}
	
	@objc private func barButtonTapped(sender: UIBarButtonItem) {
		AuthService.logout(onSuccess: {
			let vc = WelcomeController()
			let navigationController = UINavigationController(rootViewController: vc)
			self.present(navigationController, animated: true, completion: nil)
		}) { (errorMessage) in
			ProgressHUD.showError(errorMessage)
		}
	}
}
