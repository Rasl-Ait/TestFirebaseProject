//
//  AppDelegate.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		// Configure Firebase
		FirebaseApp.configure()
		
		// Configure Facebook Login
		FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
		
		// Configure Google Sign in
		GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
		
		Router.shared.root(&window)
		
		setupDefaultColors()
		
		return true
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		var handled = false
		
		if url.absoluteString.contains("fb") {
			handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
			
		} else {
			handled = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
		}
		
		return handled
	}
	
	func setupDefaultColors() {
		let color = #colorLiteral(red: 0.2549019608, green: 0.2745098039, blue: 0.3019607843, alpha: 1)
		let tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9541952055)
		
		UITabBar.appearance().tintColor = tintColor
		UITabBar.appearance().barTintColor = color
		UITabBar.appearance().isTranslucent = false
		
		UINavigationBar.appearance().barStyle = .black
		UINavigationBar.appearance().tintColor = tintColor
		UINavigationBar.appearance().isTranslucent = false
		UINavigationBar.appearance().barTintColor = color
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
		UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
}

