//
//  Validator.swift
//  VKApp
//
//  Created by rasl on 28.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation

enum Validators {
	static func isSimpleEmail(_ email: String) -> Bool {
		let emailRegEx = "^.+@.+\\..{2,}$"
		return check(text: email, regEx: emailRegEx)
	}
	
	private static func check(text: String, regEx: String) -> Bool {
		let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
		return predicate.evaluate(with: text)
	}
}
