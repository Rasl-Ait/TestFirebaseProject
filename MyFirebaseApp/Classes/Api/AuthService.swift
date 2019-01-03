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
	
	static private let auth = Auth.auth()
	
	static func signIn(with model: AuthModel, completion: @escaping ItemClosure<AuthResult>) {
		
		guard model.isFilled else { return }
		guard let email = model.email, let password = model.password else {
			completion(AuthResult.error("Something wrong with email or password. Please try again"))
			return }
		
		auth.signIn(withEmail: email, password: password) { (result, error) in
			if let error = error {
				completion(AuthResult.error(error.localizedDescription))
				return
			}
			
			completion(AuthResult.success)
		}
	}
	
	static func register(with model: RegisterModel, completion: @escaping ResultHandler<Void>) {
		guard model.isFilled else {
			completion(.failure(RegisterErrors.unknownError))
			return
		}
		guard let username = model.username, let email = model.email, let password = model.password else {
			completion(.failure(RegisterErrors.unknownError))
			return
		}
		
		/// eazy validation for @ and dot localy. other ones are on the server
		guard Validators.isSimpleEmail(email) else {
			completion(.failure(RegisterErrors.invalidEmail))
			return
		}
		
		auth.createUser(withEmail: email, password: password) { (result, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let res = result else {
				completion(.failure(RegisterErrors.unknownError))
				return
			}
			
			guard let imageData = model.profileImageUrl?.jpegData(compressionQuality: 0.5) else { return }
			
			let storageRef = Storage.storage().reference().child(Keys.avatars.rawValue).child(res.user.uid)
			
			let metadata = StorageMetadata()
			metadata.contentType = "image/jpg"
			
			storageRef.putData(imageData, metadata: metadata) { metadata, error in
				if error != nil {
					print("Couldn't Upload Image")
				} else {
					storageRef.downloadURL { url, error in
						if let error = error {
							completion(.failure(error))
							return
						}
						if url != nil {
							
							let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
							changeRequest?.displayName = username
							changeRequest?.photoURL = url
							changeRequest?.commitChanges { error in
								if let error = error {
									completion(.failure(error))
									return
								}
							}
							
							res.user.sendEmailVerification(completion: nil)
							
							var dict = model.dict
							dict["profileImageUrl"] = url!.absoluteString
							dict["id"] = res.user.uid
							
							self.registerUserIntoDatabase(uid: res.user.uid, dict: dict, completion: completion)
							
						}
					}
				}
			}
		}
	}
	
	// MARK: Database method
	static func registerUserIntoDatabase(uid: String, dict: [String : Any],  completion: @escaping ResultHandler<Void>) {
		let usersReference = Api.User.REF_USERS.child(uid)
		usersReference.setValue(dict) { error, ref in
			if let error = error {
				completion(.failure(error))
				return
			}
			print("Saved user sucessfully into Firebase db")
			completion(.success(()))
			
		}
	}
	
	static func updateUserInfor(with model: RegisterModel, completion: @escaping ResultHandler<Void>) {
		//		guard model.isFilled else {
		//			completion(.failure(RegisterErrors.unknownError))
		//			return
		//		}
		guard let username = model.username, let email = model.email else {
			completion(.failure(RegisterErrors.unknownError))
			return
		}
		
		Api.User.CURRENT_USER?.updateEmail(to: email) { (error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let user = Api.User.CURRENT_USER else { return }
			guard let imageData = model.profileImageUrl?.jpegData(compressionQuality: 0.5) else { return }
			
			let storageRef = Storage.storage().reference().child(Keys.avatars.rawValue).child(user.uid)
			
			let metadata = StorageMetadata()
			metadata.contentType = "image/jpg"
			
			storageRef.putData(imageData, metadata: metadata) { metadata, error in
				if let error = error {
					completion(.failure(error))
					return
				} else {
					storageRef.downloadURL { url, error in
						if let error = error {
							completion(.failure(error))
							return
						}
						if url != nil {
							
							let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
							changeRequest?.displayName = username
							changeRequest?.photoURL = url
							changeRequest?.commitChanges { error in
								if let error = error {
									completion(.failure(error))
									return
								}
							}
							
							var dict = model.dict
							dict["profileImageUrl"] = url!.absoluteString
							
							self.updateDatabase(dict: dict, completion: completion)
							
						}
					}
				}
			}
		}
	}
	
	
	static func updateDatabase(dict: [String : Any], completion: @escaping ResultHandler<Void>) {
		Api.User.REF_CURRENT_USER?.updateChildValues(dict) { (error, ref) in
			if let error = error {
				completion(.failure(error))
				return
			}
			print("Saved user sucessfully into Firebase db")
			completion(.success(()))
		}
	}
	
	static func logout(completion: @escaping ResultHandler<Void>) {
		do {
			try Auth.auth().signOut()
			completion(.success(()))
		} catch let logoutError {
			completion(.failure(logoutError))
		}
	}
}

extension AuthService {
	private enum Keys: String {
		case avatars
	}
}

