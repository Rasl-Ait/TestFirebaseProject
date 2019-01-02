//
//  SearchController.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit
import Firebase

class SearchController: UICollectionViewController{
	
	private let searchController = UISearchController(searchResultsController: nil)
	private var viewModel: SearchModelController!
	private let minItemSpacing = 5.5
	
	lazy var actitvityIndicatorView: UIActivityIndicatorView = {
		let act = UIActivityIndicatorView()
		act.translatesAutoresizingMaskIntoConstraints = false
		act.color = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
		act.hidesWhenStopped = true
		act.isHidden = true
		return act
		
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialized()
		
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
		
	}
	
	// MARK: - Collection view data source
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.imageCont
	}
	
	override func collectionView(_ collectionView: UICollectionView,
															 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.reuseIdentifier,
																									for: indexPath) as! ImageCollectionCell
		
		let image = viewModel.images(at: indexPath)
		
		let ref = Api.Image.REF_IMAGES.queryOrdered(byChild: "id").queryEqual(toValue: image.id)
		
		ref.observe(.value) { (snapshot)  in
			if snapshot.exists() {
				cell.selectionImage.image = UIImage(named: "checked")
				cell.selectionImage.isUserInteractionEnabled = false
				
			}
			else {
				cell.selectionImage.image = UIImage(named: "unchecked")
				cell.selectionImage.isUserInteractionEnabled = true
				
			}
			
			ref.removeAllObservers()
		}
		
		cell.index = indexPath.item
		cell.pixabayImage = image
		cell.delegate = self
		
		return cell
	}
	
	
	// MARK: - Collection view delegate
	
	override func collectionView(_ collectionView: UICollectionView,
															 willDisplay cell: UICollectionViewCell,
															 forItemAt indexPath: IndexPath) {
		
		if indexPath.row == viewModel.imagesArray.count - 5 {
			viewModel.fetchSearchImage(true)
			
		}
	}
}

private extension SearchController {
	private func initialized() {
		view.backgroundColor = .white
		setupSearchBar()
		setupCollectionView()
		setupActitvityIndicator()
		
		viewModel = SearchModelController(delegate: self)
	}
	
	private func setupCollectionView() {
		collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.reuseIdentifier)
		collectionView.contentInset = UIEdgeInsets(top: 10, left: 1, bottom: 0, right: 1)
		collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		
	}
	
	private func setupActitvityIndicator() {
		view.addSubview(actitvityIndicatorView)
		
		actitvityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		actitvityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		
		
	}

	private func setupSearchBar() {
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search for a image"
		searchController.searchBar.tintColor = .white
		searchController.searchBar.delegate = self
		definesPresentationContext = true
		
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchController: UICollectionViewDelegateFlowLayout {
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

// MARK: - SearchControllerModelDelegate

extension SearchController: SearchModelControllerDelegate, AlertDisplayer {
	func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?, images: [PixabayImage]) {
		actitvityIndicatorView.stopAnimating()
		collectionView.isHidden = false
		collectionView.reloadData()
		
	}
	
	func onFetchFailed(with reason: String) {
		actitvityIndicatorView.stopAnimating()
		let title = "Warning"
		let action = UIAlertAction(title: "OK", style: .default)
		displayAlert(with: title , message: reason, actions: [action])
		
	}
}

extension SearchController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(true, animated: true)
		viewModel.imagesArray.removeAll()
		collectionView.reloadData()
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(false, animated: true)
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if let searchText = searchController.searchBar.text {
			if searchText != "" {
				actitvityIndicatorView.startAnimating()
				viewModel.searchText(searchText)
				viewModel.currentPage = 1
				viewModel.fetchSearchImage(true)
				
			}
		}
	}
}

// MARK: - SearchCellDelegare

extension SearchController: ImageCollectionDelegare {
	func selectedSaveImage(at index: Int) {
		let image = viewModel.imagesArray[index]
		
		let imageModel = Image()
		
		imageModel.id = image.id
		imageModel.largeImageUrl = image.largeImageURL
		imageModel.username = image.user
		imageModel.likeCount = image.likes
		imageModel.webformatUrl = image.webformatURL
		imageModel.userImageUrl = image.userImageURL
		
		HelperService.filterDataToDatabase(with: imageModel) {}

	}
}


