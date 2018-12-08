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
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
        
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let storageRef = Storage.storage().reference().child("profile_image").child(uid)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            storageRef.putData(imageData, metadata: metadata) { metadata, error in
                if error != nil {
                    print("Couldn't Upload Image")
                } else {
                    storageRef.downloadURL { url, error in
                        if error != nil {
                            print(error!)
                            return
                        }
                        if url != nil {
                            
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = username
                            changeRequest?.photoURL = url
                            changeRequest?.commitChanges { error in
                                if error != nil {
                                    print(error!.localizedDescription)
                                    
                                }
                            }
                            
                            let values = ["name": username,
                                          "username_lowercase": username.lowercased(),
                                          "email": email,
                                          "profileImageURL": url!.absoluteString] as [String : AnyObject]
                            self.registerUserIntoDatabaseWithUID(uid: uid, values: values, onSuccess: onSuccess)
                            
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Database method
    static func registerUserIntoDatabaseWithUID(uid: String, values: [String : AnyObject], onSuccess: @escaping () -> Void) {
        let databaseRef = Database.database().reference().child("users").child(uid)
        databaseRef.setValue(values) { error, ref in
            if error != nil {
                print(error!.localizedDescription)
            }
            databaseRef.setValue(values)
            print("Saved user sucessfully into Firebase db")
            onSuccess()
            
            
        }
    }
    
//    static func updateUserInfor(username: String, email: String, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
//        Api.User.CURRENT_USER?.updateEmail(to: email) { (error) in
//            if error != nil {
//                onError(error!.localizedDescription)
//            } else  {
//                guard let uid = Auth.auth().currentUser?.uid else { return }
//                let storageRef = Storage.storage().reference().child("profile_image").child(uid)
//                
//                let metadata = StorageMetadata()
//                metadata.contentType = "image/jpg"
//                
//                storageRef.putData(imageData, metadata: metadata) { metadata, error in
//                    if error != nil {
//                        print("Couldn't Upload Image")
//                    } else {
//                        print("Uploaded")
//                        storageRef.downloadURL { url, error in
//                            if error != nil {
//                                print(error!)
//                                return
//                            }
//                            if url != nil {
//                                
//                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                                changeRequest?.displayName = username
//                                changeRequest?.photoURL = url
//                                changeRequest?.commitChanges { error in
//                                    if error != nil {
//                                        print(error!.localizedDescription)
//                                        
//                                    }
//                                }
//                                
//                                if let profileUrl = url?.absoluteString {
//                                    let dict = ["name": username, "username_lowercase": username.lowercased(), "email": email, "profileImageURL": profileUrl] as [String : AnyObject]
//                                    self.updateDatabase(dict: dict, onSuccess: onSuccess, onError: onError)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    static func updateDatabase(dict: [String : AnyObject], onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
//        Api.User.REF_CURRENT_USER?.updateChildValues(dict) { (error, ref) in
//            if error != nil {
//                onError(error!.localizedDescription)
//            } else  {
//                onSuccess()
//            }
//        }
//    }
    
    static func logout(onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch let logoutError {
            onError(logoutError.localizedDescription)
        }
    }
}

