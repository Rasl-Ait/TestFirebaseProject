//
//  UserModel.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation

class RegisterModel {
	var email: String?
	var profileImageUrl: UIImage?
	var image: String?
	var username: String?
	var password: String?
	var id: String?
	var userId: String
	
	init() {
		self.userId = UUID.init().uuidString
	}
	
	var isFilled: Bool {
		guard !(email ?? "").isEmpty, !(username ?? "").isEmpty, !(password ?? "").isEmpty  else {
			return false
		}
		
		return true
	}
	
	var dict: [String: Any] {
		return [
			"email": email ?? "",
			"username": username?.lowercased() ?? "",
			"password": password ?? ""
		]
	}
}

extension RegisterModel {
	static func transformUser(key: String, dict: [String: Any]) -> RegisterModel {
		let user = RegisterModel()
		user.email = dict["email"] as? String
		user.image = dict["profileImageUrl"] as? String
		user.username = dict["username"] as? String
		user.password = dict["password"] as? String
		user.id = key
		return user
	}
}

