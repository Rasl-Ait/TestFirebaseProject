//
//  PhotoView.swift
//  MyFirebaseApp
//
//  Created by rasl on 22.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

final class PhotoView: UIView {
	private let stackView = UIStackView()
	private let placeHolderImage = UIImageView()
	private var button = UIButton()
	private let imageView = UIImageView()
	
	var clicked: VoidClosure?
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		Decorator.decorate(self)
		addButton()
		addplaceHolderImage()
		addImageView()
		addTargets()
	}
	
	private func addTargets() {
		button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
	}
	
	@objc private func buttonTapped(sender: UIButton) {
		clicked?()
	}
	
	func set(image: UIImage?) {
		imageView.image = image
		
	}
	
	func setImage(image: String?) {
		imageView.setImage(fromString: image, placeholder: #imageLiteral(resourceName: "placeholderImg.jpeg"))
		
	}
	
	private func addImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		addSubview(imageView)
		
		imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
	}
	
	private func addButton() {
		button = UIButton(type: .system)
		button.setTitle("Change Profile Photo", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		addSubview(button)
		
		let constraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[button]|,V:[button]-16-|", dict: ["button": button])
		addConstraints(constraints)
	}
	
	private func addplaceHolderImage() {
		placeHolderImage.translatesAutoresizingMaskIntoConstraints = false
		placeHolderImage.contentMode = .scaleAspectFill
		placeHolderImage.image = #imageLiteral(resourceName: "placeholderImg.jpeg")
		placeHolderImage.clipsToBounds = true
		addSubview(placeHolderImage)
		
		placeHolderImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		placeHolderImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		placeHolderImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
		placeHolderImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		Decorator.layoutSubviews(self)
	}
}


extension PhotoView {
	fileprivate final class Decorator {
		static func decorate(_ view: PhotoView) {
			view.backgroundColor = .white
		}
		
		static func layoutSubviews(_ view: PhotoView) {
			view.imageView.round()
			view.placeHolderImage.round()
		}
	}
}
