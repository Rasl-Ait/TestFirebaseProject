//
//  ImageView.swift
//  MyFirebaseApp
//
//  Created by rasl on 02.01.2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import UIKit

final class ImageCellView: UIView {
	
	private let containerViewSecond = UIView()
	private let likeImage = UIImageView()
	private let likeLabel = UILabel()
	private let stackView = UIStackView()
	private let selectionImage = UIImageView()
	let imagePixabay = UIImageView()
	
	var clicked: ItemClosure<Int>?
	
	override func didMoveToWindow() {
		super.didMoveToWindow()
		Decorator.decorate(self)
		addContainerViewSecond()
		addImagePixabay()
		addStackView()
		addLikeImage()
		addSelectionImage()
		addTargets()
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		Decorator.layoutSubviews(self)
	}
	
	func prepareReuse() {
			likeLabel.text = ""
			imagePixabay.image = nil
	}
	
	func setImage(with image: String, isEnabled: Bool) {
		selectionImage.image = UIImage(named: image)
		selectionImage.isUserInteractionEnabled = isEnabled
	}
	
	func set(with lakes: String?, image: String?) {
		likeLabel.text = lakes
		imagePixabay.setImage(fromString: image, placeholder: #imageLiteral(resourceName: "logo_square"))
	}
	
	func setImage(isSelected: Bool) {
		selectionImage.image = isSelected ? UIImage(named: "checked") : UIImage(named: "unchecked")
	}
	
	func setSelectionImage(isEnabled: Bool, isHidden: Bool) {
		selectionImage.isUserInteractionEnabled = isEnabled
		selectionImage.isHidden = !isHidden
	}
	
	private func addSelectionImage() {
		selectionImage.translatesAutoresizingMaskIntoConstraints = false
		selectionImage.image = #imageLiteral(resourceName: "unchecked")
		selectionImage.contentMode = .scaleToFill
		containerViewSecond.addSubview(selectionImage)
		
		selectionImage.topAnchor.constraint(equalTo: containerViewSecond.topAnchor, constant: 6).isActive = true
		selectionImage.rightAnchor.constraint(equalTo: containerViewSecond.rightAnchor, constant: -6).isActive = true
		selectionImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
		selectionImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
		
	}
	
	private func addContainerViewSecond() {
		containerViewSecond.translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		addSubview(containerViewSecond)
		
		containerViewSecond.topAnchor.constraint(equalTo: topAnchor).isActive = true
		containerViewSecond.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		containerViewSecond.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		containerViewSecond.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
	}
	
	private func addImagePixabay() {
		imagePixabay.translatesAutoresizingMaskIntoConstraints = false
		imagePixabay.contentMode = .scaleAspectFill
		containerViewSecond.addSubview(imagePixabay)
		
		imagePixabay.topAnchor.constraint(equalTo: containerViewSecond.topAnchor).isActive = true
		imagePixabay.leftAnchor.constraint(equalTo: containerViewSecond.leftAnchor).isActive = true
		imagePixabay.rightAnchor.constraint(equalTo: containerViewSecond.rightAnchor).isActive = true
		imagePixabay.bottomAnchor.constraint(equalTo: containerViewSecond.bottomAnchor).isActive = true
		
		
	}
	
	private func addStackView() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.spacing = 3
		stackView.distribution = .fill
		stackView.alignment = .fill
		containerViewSecond.addSubview(stackView)
		
		stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -6).isActive = true
		stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
		
	}
	
	private func addLikeImage() {
		likeImage.translatesAutoresizingMaskIntoConstraints = false
		likeImage.contentMode = .scaleAspectFit
		likeImage.image = UIImage(named: "like")
		stackView.addArrangedSubview(likeImage)
		
		likeImage.heightAnchor.constraint(equalToConstant: 13).isActive = true
		likeImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
		
	}
	
	private func addLikeLabel() {
		likeLabel.translatesAutoresizingMaskIntoConstraints = false
		likeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		likeLabel.text = "10000"
		likeLabel.font = UIFont.boldSystemFont(ofSize: 12)
		stackView.addArrangedSubview(likeLabel)
		
	}
	
	// MARK: - Actions
	
	private func addTargets() {
		selectionImage.addGestureRecognizer(UITapGestureRecognizer(target: self,
																															 action: #selector(buttonClicked(_:))))
		selectionImage.isUserInteractionEnabled = true
	}
	
	@objc private func buttonClicked(_ sender: UIButton) {
		selectionImage.image = UIImage(named: "checked")
		clicked?(0)
		
	}
}

extension ImageCellView {
	fileprivate final class Decorator {
		static func decorate(_ view: ImageCellView) {
			view.backgroundColor = .white
		}
		
		static func layoutSubviews(_ view: ImageCellView) {
			view.layer.cornerRadius = 9
			view.layer.shadowOpacity = 0.70
			view.layer.shadowOffset = CGSize(width: 0, height: 5)
			view.layer.shadowRadius = 5
			
			view.containerViewSecond.layer.cornerRadius = 9
			view.containerViewSecond.clipsToBounds = true
			
		}
	}
}

