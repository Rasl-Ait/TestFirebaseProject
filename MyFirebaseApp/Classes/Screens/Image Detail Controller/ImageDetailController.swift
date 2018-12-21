//
//  ImageDetailController.swift
//  MyFirebaseApp
//
//  Created by rasl on 21.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class ImageDetailController: UIViewController {
	
  let containerContent = UIView()
	private let pixabayImage = UIImageView()
	private let userImage = UIImageView()
	private let userNameLabel = UILabel()
	private let backgroundImage = UIImageView()
	private var closeButton = UIButton()

	var modelImage: Image? {
		didSet {
			guard let model = modelImage else { return }
			loadContent(model)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialized()

	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	// MARK - Actions
	
	@objc private func closeButtonTapped(sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
}

private extension ImageDetailController {
	private func initialized() {
		view.backgroundColor = .white
		addBackgroudImage()
		addContainerContent()
		addBlurEffect()
		addPixabayImage()
		addCloseButton()
		addTargets()

	}
	
	private func loadContent(_ model: Image) {
		pixabayImage.setImage(fromString: model.largeImageUrl, placeholder: UIImage(named: "logo_square"))
		backgroundImage.setImage(fromString: model.largeImageUrl, placeholder: UIImage(named: "logo_square"))
		
	}
	
	private func addContainerContent() {
		containerContent.translatesAutoresizingMaskIntoConstraints = false
		containerContent.backgroundColor = .clear
		view.addSubview(containerContent)
		
		containerContent.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		containerContent.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		containerContent.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		containerContent.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
	}
	
	private func addBackgroudImage() {
		backgroundImage.translatesAutoresizingMaskIntoConstraints = false
		backgroundImage.contentMode = .scaleAspectFill
		view.addSubview(backgroundImage)
		
		backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
	}
	
	
	private func addBlurEffect() {
		let blurEffect = UIBlurEffect(style: .dark)
		let blurView = UIVisualEffectView(effect: blurEffect)
		blurView.translatesAutoresizingMaskIntoConstraints = false
		containerContent.insertSubview(blurView, at: 1)
		
		blurView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
		blurView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		
	}
	
	private func addCloseButton() {
		closeButton = UIButton(type: .system)
		closeButton.setImage(UIImage(named: "cross"), for: .normal)
		closeButton.tintColor = .white
		containerContent.addSubview(closeButton)
		
		closeButton.anchor(top: containerContent.topAnchor,
										left: nil,
										bottom: nil,
										right: containerContent.rightAnchor,
										paddingTop: 40,
										paddingLeft: 0,
										paddingBottom: 0,
										paddingRight: 8,
										width: 36, height: 36)

	}
	
	private func addTargets() {
		closeButton.addTarget(self, action: #selector(closeButtonTapped(sender:)), for: .touchUpInside)
	}
	
	private func addPixabayImage() {
		pixabayImage.contentMode = .scaleAspectFit
		containerContent.addSubview(pixabayImage)
		
		pixabayImage.anchor(top: containerContent.topAnchor,
												left: containerContent.leftAnchor,
												bottom: containerContent.bottomAnchor,
												right: containerContent.rightAnchor,
												paddingTop: 50,
												paddingLeft: 0,
												paddingBottom: 50,
												paddingRight: 0,
												width: 200, height: 200)
		
	}
}
