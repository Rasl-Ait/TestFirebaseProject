//
//  ProfileUserCell.swift
//  MyFirebaseApp
//
//  Created by rasl on 22.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class PhotoUserCell: UITableViewCell {
	
	static let reuseIdentifier = "PhotoUserCell"
	
	private let photoView = PhotoView()
	
	var photoViewClicked: VoidClosure? {
		didSet {
			photoView.clicked = photoViewClicked
		}
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		Decorator.decorate(cell: self)
		addPhotoView()
	}
	
	func set(image: UIImage?) {
		photoView.set(image: image)
	}
	
	private func addPhotoView() {
		photoView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(photoView)
		
		photoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		photoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		photoView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		photoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PhotoUserCell {
	fileprivate class Decorator {
		static func decorate(cell: PhotoUserCell) {
			cell.selectionStyle = .none

		}
	}
}
