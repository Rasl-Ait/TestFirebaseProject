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
	private let models: [HeaderModel] = [.info, .button]
	private var registerModel = RegisterModel()
	
	lazy var photoPickerManager: PhotoPickerManager = {
		let pickerManager = PhotoPickerManager(presentingController: self)
		pickerManager.delegate = self
		return pickerManager
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialized()
		
	}
}

extension ProfileUserController {
	fileprivate class Decorator {
		static func decorate(vc: ProfileUserController) {
			vc.tableView.separatorColor = .clear
			vc.tableView.keyboardDismissMode = .onDrag
			vc.tableView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
			vc.view.backgroundColor = .white
			
		}
	}
}

extension ProfileUserController {
	fileprivate enum CellModel {
		case userInfo
		case button
	}
	
	fileprivate enum HeaderModel: CellHeaderProtocol {
		typealias CellType = CellModel
		case info
		case button
		
		var cellModels: [ProfileUserController.CellModel] {
			switch self {
			case .info: return [.userInfo]
			case .button: return [.button]
			}
		}
	}
}


private extension ProfileUserController {
	func initialized() {
		Decorator.decorate(vc: self)
		registerCells()
		setupTableView()
		//loadUser()
	}
	
//	private func loadUser() {
//		guard let userId = Api.User.CURRENT_USER?.uid else { fatalError() }
//		Api.User.observeUser(withId: userId) { user in
//			self.registerModel = user
//			self.tableView.reloadData()
//		}
//	}
	
	private func registerCells() {
		tableView.register(InfoUserCell.self, forCellReuseIdentifier: InfoUserCell.reuseIdentifier)
		tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseIdentifier)
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		view.addSubview(tableView)
		
		tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor,
										 right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0,
										 paddingRight: 0, width: 0, height: 0)
		
	}
	
	private func photoViewClicked() {
		photoPickerManager.presentPhotoPicker(animated: true)
	}
	
	private func saveButtonClicked() {
		ProgressHUD.show("Waiting...")
		AuthService.updateUserInfor(with: registerModel) { ( result ) in
			switch result {
			case .success(_):
				ProgressHUD.showSuccess("Success")
			case .failure(let error):
				ProgressHUD.showError(error.localizedDescription)
			}
		}
	}
	
	private func logOutButtonClicked() {
		AuthService.logout { result in
			switch result {
			case .success(_):
				let vc = WelcomeController()
				let navigationController = UINavigationController(rootViewController: vc)
				self.present(navigationController, animated: true, completion: nil)
				ProgressHUD.showSuccess("Success")
			case .failure(let error):
				ProgressHUD.showError(error.localizedDescription)
			}
		}
	}
}

extension ProfileUserController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let model = models[indexPath.section].cellModels[indexPath.row]
		switch model {
		case .userInfo:
			return 288
		case .button:
			return 88
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		return headerView
		
	}
}

extension ProfileUserController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let headerModel = models[section]
		switch headerModel {
		case .button:
			return 44
		default: return 0
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return models.count
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models[section].cellModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.section].cellModels[indexPath.row]
		switch model {
		case .userInfo:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserCell.reuseIdentifier,
																										 for: indexPath) as? InfoUserCell else { fatalError() }
			
			guard let userId = Api.User.CURRENT_USER?.uid else { fatalError() }
			Api.User.observeUser(withId: userId) { user in
			cell.model = user
			}
		
			cell.set(image: registerModel.profileImageUrl)
			cell.photoViewClicked = self.photoViewClicked
			return cell
		case .button:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier,
																										 for: indexPath) as? ButtonCell else { fatalError() }
			
			cell.saveButtonViewClicked = self.saveButtonClicked
			cell.logOutButtonViewClicked = self.logOutButtonClicked
			
			return cell
			
		}
	}
}

// MARK: - PhotoPickerManagerDelegate

extension ProfileUserController: PhotoPickerManagerDelegate {
	func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
		manager.dismissPhotoPicker(animated: true, completion: nil)
		
		registerModel.profileImageUrl = image
		tableView.reloadData()
		
	}
}


