//
//  UserApi.swift
//  MyFirebaseApp
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//


import Foundation
import Firebase

class UserApi {
	var REF_USERS = Database.database().reference().child("users")
	
	func observeUser(withId uid: String, completion: @escaping ItemClosure<UserModel>) {
		REF_USERS.child(uid).observeSingleEvent(of: .value) {
			snapshot in
			if let dict = snapshot.value as? [String: Any] {
				let user = UserModel.transformUser(key: snapshot.key, dict: dict)
				completion(user)
			}
		}
	}
	
	var CURRENT_USER: User? {
		if let currentUser = Auth.auth().currentUser {
			return currentUser
		}
		
		return nil
	}
}
