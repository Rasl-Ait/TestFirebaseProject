//
//  ImageModelController.swift
//  ImageTestProject
//
//  Created by rasl on 29.11.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation


protocol SearchModelControllerDelegate: class {
    func onFetchCompleted(with images: [PixabayImage])
    func onFetchFailed(with reason: String)
}

class SearchModelController {
    
    private let client = PixabayClient.init()
    private weak var delegate: SearchModelControllerDelegate?
    var imagesArray: [PixabayImage] = []
    
    var currentPage = 1
    private var searchText = ""
    
    init(delegate: SearchModelControllerDelegate) {
        self.delegate = delegate
    }
    
    var imageCont: Int {
        return imagesArray.count
    }
    
    func searchText(_ text: String) {
        searchText = text
    }
    
    func images(at index: IndexPath) -> PixabayImage {
        return imagesArray[index.item]
    }
    
    func fetchSearchImage(_ isfetch: Bool) {
        
        client.fetchSearchImage(with: .searchImage(with: searchText, page: currentPage)) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let result):
                DispatchQueue.main.async {
                    self?.currentPage += 1
                    self?.imagesArray.append(contentsOf: result.hits)
                    self?.delegate?.onFetchCompleted(with: self?.imagesArray ?? [])
                    
                }
            }
        }
    }
}
