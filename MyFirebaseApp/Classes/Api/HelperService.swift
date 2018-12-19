//
//  HelperService.swift
//  MyFirebaseApp
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//


import Foundation
import Firebase

class HelperService {
	static func sendDataToDatabase(with model: Image, onSuccess: @escaping VoidClosure) {
		guard let newImageId = Api.Image.REF_IMAGES.childByAutoId().key else { return }
		let newImagetRef = Api.Image.REF_IMAGES.child(newImageId)
		guard let currentUser = Api.User.CURRENT_USER  else { return }
		let currentUserId = currentUser.uid
		
		var dict = model.dict
		dict["uid"] = currentUserId
		
		newImagetRef.setValue(dict) { error, ref in
			if let error = error  {
				ProgressHUD.showError(error.localizedDescription)
				return
			}
			
			let myImageRef = Api.MyImages.REF_MY_IMAGES.child(currentUserId).child(newImageId)
			myImageRef.setValue(true, withCompletionBlock: { (error, ref) in
				if let error = error {
					ProgressHUD.showError(error.localizedDescription)
					return
				}
			})
			
			ProgressHUD.showSuccess("Success")
			onSuccess()
			
		}
	}
}
