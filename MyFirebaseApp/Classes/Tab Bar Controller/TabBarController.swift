//
//  TabBarController.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit
import  Firebase

class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if Auth.auth().currentUser == nil {
			DispatchQueue.main.async {
				let layout = UICollectionViewFlowLayout()
				let searchController = SearchController(collectionViewLayout: layout)
				let navController = UINavigationController(rootViewController: searchController)
				self.present(navController, animated: true, completion: nil)
			}
			
			return
		}
		
		setupViewControllers()
	}
	
	func setupViewControllers() {
		
		let searchController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Search.png"),
																								 selectedImage: #imageLiteral(resourceName: "Search_Selected.png"),
																								 rootViewController: SearchController(
																									collectionViewLayout: UICollectionViewFlowLayout()))
		
		let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "star.png"), selectedImage: #imageLiteral(resourceName: "star.png"),
																									rootViewController: FavoriteController(
																										collectionViewLayout: UICollectionViewFlowLayout()))
		
		let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"),
																												 rootViewController: ProfileUserController())
		
		
		viewControllers = [searchController,
											 plusNavController,
											 userProfileNavController]
		
		guard let items = tabBar.items else { return }
		
		for item in items {
			item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
		}
	}
	
	fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
		let viewController = rootViewController
		let navController = UINavigationController(rootViewController: viewController)
		navController.tabBarItem.image = unselectedImage
		navController.tabBarItem.selectedImage = selectedImage
		return navController
		
	}
}






