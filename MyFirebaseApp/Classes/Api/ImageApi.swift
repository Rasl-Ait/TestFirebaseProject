//
//  PostApi.swift
//  MyFirebaseApp
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation
import Firebase
class ImageApi {
    var REF_IMAGES = Database.database().reference().child("images")
    
    func observeImage(withId id: String, completion: @escaping ItemClosure<Image>) {
        REF_IMAGES.child(id).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
							let image = Image.transformImage(snapshot: snapshot, dict: dict)
                completion(image)
            }
        }
    }
	
	func filterDatabase() {
		
	
	}
}
