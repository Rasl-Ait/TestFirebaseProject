//
//  RegisterController.swift
//  MyFirebaseApp
//
//  Created by rasl on 05.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    private var selectedImage: UIImage?
    
    lazy var containerView: RegisterContainerVIew = {
        let view = RegisterContainerVIew()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialized()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

private extension RegisterController {
    private func initialized() {
        title = "Login"
        view.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
        addContainerView()

    }
    
    private func addContainerView() {
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor,
                             left: view.leftAnchor,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 150,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0, height: 0)
        
    }
}

extension RegisterController: RegisterContainerVIewDelegate {
    func signUpTappedButton(with name: String, email: String, password: String, data: Data) {
        view.endEditing(true)
        AuthService.signUp(username: name, email: email, password: password, imageData: data, onSuccess: {
            ProgressHUD.showSuccess("Success")
            //self.performSegue(withIdentifier: "signUpToTabBarVC", sender: nil)
        }) { (error) in
            ProgressHUD.showError(error!)
     
        }
    }
    
    func addImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        present(pickerController, animated: true, completion: nil)
    }
}

// MARK: -  UIImagePickerControllerDelegate
extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
       // let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = image
            containerView.profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

