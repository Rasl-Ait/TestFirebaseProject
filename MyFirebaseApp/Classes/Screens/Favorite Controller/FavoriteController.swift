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
	private let profileImageView = UIImageView()
	private let profilename = UILabel()
	private var trashButton = UIBarButtonItem()
	
	private var images: [Image] = []
	private let minItemSpacing = 5.5
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialized()
		
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		
		collectionView.allowsMultipleSelection = editing
		let indexes = collectionView.indexPathsForVisibleItems
		for index in indexes {
			let cell = collectionView.cellForItem(at: index) as! ImageCollectionCell
			cell.isEditing = editing
			
		}
		
		if !editing {
			trashButton.isEnabled = false
		}
	}
	
	// MARK: - Actions
	
	@objc private func trashButtonTapped(sender: UIBarButtonItem) {
		if let selected = collectionView.indexPathsForSelectedItems {
			let items = selected.map{$0.item}.sorted().reversed()
			
			for item in items {
				let image = images[item]
				images.remove(at: item)
				HelperService.sendDataRemoveToDatabase(with: image) {
					ProgressHUD.showSuccess("Delete")
				}
				
			}
			
			collectionView.deleteItems(at: selected)
			
		}
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
		cell.isEditing = isEditing
		
		return cell
	}
	
	// MARK: - Collection view delegate
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if !isEditing {
			
		} else {
			trashButton.isEnabled = true
		}
	}
}

// MARK: - FavoriteController

private extension FavoriteController {
	private func initialized() {
		view.backgroundColor = .white
		setupCollectionView()
		addStackView()
		addProfileImage()
		addProfileName()
		fetchMyImages()
		fetchUser()
		setupNavigationBar()
		
	}
	
	private func setupNavigationBar() {
		
		trashButton = UIBarButtonItem(barButtonSystemItem: .trash,
																	target: self,
																	action: #selector(trashButtonTapped(sender:)))
		navigationItem.rightBarButtonItem = trashButton
		navigationItem.leftBarButtonItem = editButtonItem
		trashButton.isEnabled = false
		
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
			self.profileImageView.setImage(fromString: user.image, placeholder: nil)
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
		profilename.textColor = .white
		stackView.addArrangedSubview(profilename)
	}
	
	private func setupCollectionView() {
		collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.reuseIdentifier)
		collectionView.contentInset = UIEdgeInsets(top: 10, left: 1, bottom: 0, right: 1)
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
		
		let factor = traitCollection.horizontalSizeClass == .compact ? 3:2
		let screenRect = collectionView.frame.size.width
		let screenWidth = screenRect - (CGFloat(minItemSpacing) * CGFloat(factor + 1))
		let cellWidth = screenWidth / CGFloat(factor)
		
		return CGSize(width: cellWidth, height: 180)
		
	}
}



