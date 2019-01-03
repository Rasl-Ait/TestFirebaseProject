//
//  SearchCell.swift
//  RealmTestProject
//
//  Created by rasl on 17.11.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

protocol ImageCollectionDelegare: class {
	func selectedSaveImage(at index: Int)
}

class ImageCollectionCell: UICollectionViewCell {
	
	static let reuseIdentifier = "ImageCollectionCell"
	
	let containerImageView = ImageCellView()
	
	var buttonClicked: ItemClosure<Int>? {
		didSet {
			containerImageView.clicked = buttonClicked
		}
	}
	
	var isSelect = false
	var delegate: ImageCollectionDelegare?
	
	var image: Image? {
		didSet {
			configure(image)
		}
	}
	
	var pixabayImage: PixabayImage? {
		didSet {
			configure(pixabayImage)
		}
	}
	
	var isEditing: Bool = false {
		didSet {
			containerImageView.setSelectionImage(isEnabled: false, isHidden: isEditing)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addContainerImageView()
		
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		containerImageView.prepareReuse()
		
	}
	
	override var isSelected: Bool {
		didSet {
			
			if isEditing {
				containerImageView.setImage(isSelected: isSelected)
			}
		}
	}
	
	
	func selectionImage(with image: String, isEnabled: Bool) {
		containerImageView.setImage(with: image, isEnabled: isEnabled)
	}
	
	private func addContainerImageView() {
		containerImageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(containerImageView)
		
		containerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		containerImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		containerImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		containerImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
	}
	
	private func configure(_ image: PixabayImage?) {
		guard let image = image else { return }
		containerImageView.set(with: String(image.likes), image: image.webformatURL)
	}
	
	fileprivate func configure(_ image: Image?) {
		guard let image = image else { return }
		containerImageView.set(with: String(image.likeCount!), image: image.webformatUrl)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
