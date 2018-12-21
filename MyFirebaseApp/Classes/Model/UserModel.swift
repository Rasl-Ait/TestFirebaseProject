//
//  UserModel.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation

class UserModel {
	var email: String?
	var profileImageUrl: UIImage?
	var image: String?
	var username: String?
	var password: String?
	var id: String?
	
	var isFilled: Bool {
		guard !(email ?? "").isEmpty, !(username ?? "").isEmpty, !(password ?? "").isEmpty  else {
			return false
		}
		
		return true
	}
	
	var dict: [String: Any] {
		return [
			"email": email ?? "",
			"username": username ?? "",
			"password": password ?? ""
		]
	}
}

extension UserModel {
	static func transformUser(key: String, dict: [String: Any]) -> UserModel {
		let user = UserModel()
		user.email = dict["email"] as? String
		user.image = dict["profileImageUrl"] as? String
		user.username = dict["username"] as? String
		user.password = dict["password"] as? String
		user.id = key
		user.profileImageUrl = UIImage(named: user.image!)
		return user
	}
}

