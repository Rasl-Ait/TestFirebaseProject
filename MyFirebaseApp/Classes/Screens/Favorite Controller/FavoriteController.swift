//
//  FavoriteController.swift
//  MyFirebaseApp
//
//  Created by rasl on 08.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class FavoriteController: UICollectionViewController {
	
	private let stackView = UIStackView()
	private var profileImageView = UIImageView()
	private let profilename = UILabel()
	
	
	private var images: [Image] = []
	private let minItemSpacing = 5
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialized()
		
		//        AuthService.logout(onSuccess: {
		//
		//        }) { (errorMessage) in
		//
		//        }
		
	}
	
	// MARK: - Collection view data source
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	override func collectionView(_ collectionView: UICollectionView,
															 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.reuseIdentifier,
																									for: indexPath) as! ImageCollectionCell
		
		let image = images[indexPath.row]
		
		cell.index = indexPath.item
		cell.image = image
		cell.delegate = self
		
		return cell
	}
}


private extension FavoriteController {
	private func initialized() {
		view.backgroundColor = .white
		setupCollectionView()
		addStackView()
		addProfileImage()
		addProfileName()
		fetchMyImages()
		fetchUser()
		
	}
	
	private func fetchMyImages() {
		guard let userId = Api.User.CURRENT_USER?.uid else { return }
		Api.MyImages.fetchMyImages(userId: userId) { (key) in
			Api.Image.observeImage(withId: key) { (image) in
				self.images.append(image)
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			}
		}
	}
	
	private func fetchUser() {
		guard let userId = Api.User.CURRENT_USER?.uid else { return }
		Api.User.observeUser(withId: userId) { (user) in
		
		
			//self.profileImageView.setImage(fromString: user.profileImageUrl, placeholder: nil)
			self.profilename.text = user.username
		}
		
	}
	
	private func addStackView() {
		stackView.axis = .horizontal
		stackView.spacing = 10
		navigationItem.titleView = stackView
		
	}
	
	private func addProfileImage() {
		profileImageView.translatesAutoresizingMaskIntoConstraints = false
		profileImageView.contentMode = .scaleAspectFill
		profileImageView.layer.cornerRadius = 20
		profileImageView.clipsToBounds = true
		stackView.addArrangedSubview(profileImageView)
		
		profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
	}
	
	private func addProfileName() {
		profilename.font = UIFont.boldSystemFont(ofSize: 20)
		profilename.textColor = .black
		stackView.addArrangedSubview(profilename)
	}
	
	private func setupCollectionView() {
		collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.reuseIdentifier)
		collectionView.contentInset = UIEdgeInsets(top: 10, left: 2, bottom: 20, right: 2)
		collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize.zero
	}
	
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize.zero
	}
	
	func collectionView(_ collectionView: UICollectionView,
											layout collectionViewLayout: UICollectionViewLayout,
											sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let factor = traitCollection.horizontalSizeClass == .compact ? 2:3
		let screenRect = collectionView.frame.size.width
		let screenWidth = screenRect - (CGFloat(minItemSpacing) * CGFloat(factor + 1))
		let cellWidth = screenWidth / CGFloat(factor)
		
		return CGSize(width: cellWidth, height: 180)
		
	}
}

extension FavoriteController: ImageCollectionDelegare {
	func selectedSaveImage(at index: Int) {
		
	}
}


