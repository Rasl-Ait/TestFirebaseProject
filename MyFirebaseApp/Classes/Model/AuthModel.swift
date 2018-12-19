//
//  AuthModel.swift
//  MyFirebaseApp
//
//  Created by rasl on 19.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation

class AuthModel {
	var email: String?
	var password: String?
	
	var isFilled: Bool {
		guard !(email ?? "").isEmpty, !(password ?? "").isEmpty  else {
			return false
		}
		
		return true
	}
}
