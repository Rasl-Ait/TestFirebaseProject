//
//  PhotoView.swift
//  MyFirebaseApp
//
//  Created by rasl on 22.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

final class PhotoView: UIView {
	private let stackView = UIStackView()
	private let imageView = UIImageView()
	private var button = UIButton()
	
	var clicked: VoidClosure?
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		Decorator.decorate(self)
		addButton()
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
	
	private func addButton() {
		button = UIButton(type: .system)
		button.setTitle("Change Profile Photo", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		addSubview(button)
		
		let constraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[button]|,V:[button]-16-|", dict: ["button": button])
		addConstraints(constraints)
	}
	
	private func addImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = #imageLiteral(resourceName: "placeholderImg.jpeg")
		imageView.clipsToBounds = true
		addSubview(imageView)
		
		imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
		
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
		}
	}
}
