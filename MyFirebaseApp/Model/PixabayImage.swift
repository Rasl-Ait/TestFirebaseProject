//
//  PixabayImage.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation

struct PixabayImage: Decodable {
    let largeImageURL: String
    let webformatHeight, webformatWidth, likes, imageWidth: Int
    let id, userId, views, comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let type: String
    let previewHeight: Int
    let tags: String
    let downloads: Int
    let user: String
    let favorites, imageSize, previewWidth: Int
    let userImageURL: String
    let previewURL: String
    
}

struct HitImage: Decodable {
    let hits: [PixabayImage]
    let total: Int
}
