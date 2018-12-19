//
//  Image.swift
//  MyFirebaseApp
//
//  Created by rasl on 07.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation

class Image {
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
	static func transformImage(key: String, dict: [String: Any]) -> Image {
		let image = Image()
		image.userId = key
		image.id = dict["id"] as? Int
		image.username = dict["username"] as? String
		image.likeCount = dict["likeCount"] as? Int
		image.webformatUrl = dict["webformatUrl"] as? String
		image.userImageUrl = dict["userImageUrl"] as? String
		image.largeImageUrl = dict["largeImageUrl"] as? String
		
		return image
		
	}
}