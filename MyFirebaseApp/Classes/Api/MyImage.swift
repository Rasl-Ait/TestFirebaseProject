//
//  MyImage.swift
//  MyFirebaseApp
//
//  Created by rasl on 08.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation
import Firebase

class MyImageApi {
	var REF_MY_IMAGES = Database.database().reference().child("myImages")
	
	func fetchMyImages(userId: String, completion: @escaping ItemClosure<String>) {
		REF_MY_IMAGES.child(userId).observe(.childAdded) { (snapshot) in
			completion(snapshot.key)
		}
	}
	
	func observeMyImage(withId id: String, completion: @escaping ItemClosure<Image>) {
		REF_MY_IMAGES.child(id).observeSingleEvent(of: .value) { (snapshot) in
			if let dict = snapshot.value as? [String: Any] {
				let image = Image.transformImage(snapshot: snapshot, dict: dict)
				completion(image)
			}
		}
	}
	
	
}
