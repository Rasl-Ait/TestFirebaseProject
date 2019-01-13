//
//  Extesnion+UITextFIeld.swift
//  MyFirebaseApp
//
//  Created by rasl on 13/01/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import Foundation

extension UITextField {
	func setupTextField(with string: String) {
		let placeholderAttr = NSAttributedString(string: string,
																						 attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
		
		attributedPlaceholder = placeholderAttr
		textColor = .black
		textAlignment = .left
		borderStyle = .roundedRect
		
	}
}

