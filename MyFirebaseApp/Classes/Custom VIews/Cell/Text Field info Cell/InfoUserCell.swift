//
//  TextFildInfoUserCell.swift
//  MyFirebaseApp
//
//  Created by rasl on 22.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class InfoUserCell: UITableViewCell {
	static let reuseIdentifier = "InfoUserCell"
	
	private let textFieldInfo = TextInfoView()
	private let photoView = PhotoView()
	
	var photoViewClicked: VoidClosure? {
		didSet {
			photoView.clicked = photoViewClicked
		}
	}
	
	var model: RegisterModel? {
		didSet {
			configure(model)
			textChanged(model: model)
		}
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		Decorator.decorate(cell: self)
		addTextFieldInfo()
		addPhotoView()
		
	}
	
	func textChanged (model: RegisterModel?) {
		guard let model = model else { return }
		textFieldInfo.usernameTextChanged = { text in
			model.username = text
		}
		
		textFieldInfo.emailTextChanged = { text in
			model.email = text
			
		}
	}
	
	func set(image: UIImage?) {
		photoView.set(image: image)
	}
	
	private func configure(_ model: RegisterModel?) {
		guard let model = model else { return }
		textFieldInfo.set(with: model.username, email: model.email)
		photoView.setImage(image: model.image)
	}
	
	private func addPhotoView() {
		photoView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(photoView)
		
//		let constraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[photoView]|,V:[photoView]|",
//																										dict: ["photoView": photoView])
//		
//		addConstraints(constraints)
		
		photoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		photoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		photoView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		photoView.bottomAnchor.constraint(equalTo: textFieldInfo.topAnchor).isActive = true
		
		photoView.heightAnchor.constraint(equalToConstant: 200).isActive = true
		
	}
	
	private func addTextFieldInfo() {
		textFieldInfo.translatesAutoresizingMaskIntoConstraints = false
		addSubview(textFieldInfo)
		
		//textFieldInfo.topAnchor.constraint(equalTo: photoView.bottomAnchor).isActive = true
		textFieldInfo.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		textFieldInfo.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		textFieldInfo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
		textFieldInfo.heightAnchor.constraint(equalToConstant: 88).isActive = true
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension InfoUserCell {
	fileprivate class Decorator {
		static func decorate(cell: InfoUserCell) {
			cell.selectionStyle = .none
			cell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
			
		}
	}
}
