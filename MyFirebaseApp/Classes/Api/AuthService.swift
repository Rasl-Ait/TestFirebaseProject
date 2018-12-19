//
//  AuthService.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
	
	static func signIn(with model: AuthModel,
										 onSuccess: @escaping VoidClosure,
										 onError:  @escaping (_ errorMessage: String?) -> Void) {
		
		guard model.isFilled else { return }
		guard let email = model.email, let password = model.password else { return }

		
		Auth.auth().signIn(withEmail:email, password: password, completion: { (result, error) in
			if let error = error {
				onError(error.localizedDescription)
				return
			}
			onSuccess()
		}
	 )
	}
	
	static func register(with model: UserModel,
											 onSuccess: @escaping VoidClosure,
											 onError: @escaping (_ errorMessage: String?) -> Void) {
		
		guard model.isFilled else { return }
		guard let username = model.username, let email = model.email, let password = model.password else { return }
		
		
		Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
			if error != nil {
				print(error!.localizedDescription)
			}
			guard let user = Auth.auth().currentUser else { return }
			guard let imageData = model.profileImageUrl?.jpegData(compressionQuality: 0.2) else { return }
			
			let storageRef = Storage.storage().reference().child("profile_image").child(user.uid)
			
			let metadata = StorageMetadata()
			metadata.contentType = "image/jpg"
			
			storageRef.putData(imageData, metadata: metadata) { metadata, error in
				if error != nil {
					print("Couldn't Upload Image")
				} else {
					storageRef.downloadURL { url, error in
						if let error = error {
							print(error.localizedDescription)
							return
						}
						if url != nil {
							
							let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
							changeRequest?.displayName = username
							changeRequest?.photoURL = url
							changeRequest?.commitChanges { error in
								if let error = error {
									print(error.localizedDescription)
									return
								}
							}
							
							user.sendEmailVerification(completion: nil)
							
							var dict = model.dict
							dict["profileImageUrl"] = url!.absoluteString
							dict["id"] = user.uid
							
							self.registerUserIntoDatabase(uid: user.uid, dict: dict, onSuccess: onSuccess)
							
						}
					}
				}
			}
		}
	}
	
	// MARK: Database method
	static func registerUserIntoDatabase(uid: String, dict: [String : Any], onSuccess: @escaping () -> Void) {
		let databaseRef = Database.database().reference()
		let usersReference = databaseRef.child("users").child(uid)
		usersReference.setValue(dict) { error, ref in
			if let error = error {
				print(error.localizedDescription)
				return
			}
			print("Saved user sucessfully into Firebase db")
			onSuccess()
			
			
		}
	}
	
	static func logout(onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
		do {
			try Auth.auth().signOut()
			onSuccess()
		} catch let logoutError {
			onError(logoutError.localizedDescription)
		}
	}
}

