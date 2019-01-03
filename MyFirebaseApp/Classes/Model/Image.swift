//
//  Image.swift
//  MyFirebaseApp
//
//  Created by rasl on 07.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation
import Firebase

class Image {
	var ref: DatabaseReference?
	var userId: String?
	var id: Int?
	var username: String?
	var likeCount: Int?
	var webformatUrl: String?
	var userImageUrl: String?
	var largeImageUrl: String?
	
	var dict: [String: Any] {
		return [
			"id": id ?? "",
			"username": username ?? "",
			"likeCount": likeCount ?? "",
			"userImageUrl": userImageUrl ?? "",
			"webformatUrl": webformatUrl ?? "",
			"largeImageUrl": largeImageUrl ?? ""
			
		]
	}
}

extension Image {
	static func transformImage(snapshot: DataSnapshot, dict: [String: Any]) -> Image {
		let image = Image()
		image.ref = snapshot.ref
		image.userId = snapshot.key
		image.id = dict["id"] as? Int
		image.username = dict["username"] as? String
		image.likeCount = dict["likeCount"] as? Int
		image.webformatUrl = dict["webformatUrl"] as? String
		image.userImageUrl = dict["userImageUrl"] as? String
		image.largeImageUrl = dict["largeImageUrl"] as? String
		
		return image
		
	}
	
	static func saveImageData(with model: PixabayImage) -> Image {
		let image = Image()
		image.id = model.id
		image.largeImageUrl = model.largeImageURL
		image.username = model.user
		image.likeCount = model.likes
		image.webformatUrl = model.webformatURL
		image.userImageUrl = model.userImageURL
		
		return image
	}
}
