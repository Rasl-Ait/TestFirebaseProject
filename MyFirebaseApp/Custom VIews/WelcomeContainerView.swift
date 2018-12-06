//
//  VelcomeContainerView.swift
//  MyFirebaseApp
//
//  Created by rasl on 06.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

protocol WelcomeContainerViewDelegate {
    func emailTappedButton()
    func facebookTappedButton()
    func googleTappedButton()
    
}

class WelcomeContainerView: UIView {

    private let stackView = UIStackView()
    private let stackViewButton = UIStackView()
    private let signInLabel = UILabel()
    private let label = UILabel()
    private let emailButton = UIButton()
    private let facebookButton = UIButton()
    private let googleButton = UIButton()
    
    var delegate: WelcomeContainerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStackView()
        addSignInLabel()
        addStackViewBitton()
        addEmailButton()
        addFaceBookButton()
        addGoogleButton()
        addTargets()
      
    }

    private func addStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 50
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 16,
                         paddingBottom: 20,
                         paddingRight: 16,
                         width: 0, height: 0)
        
        
    }
    
    private func addStackViewBitton() {
        stackViewButton.axis = .horizontal
        stackViewButton.alignment = .fill
        stackViewButton.distribution = .fill
        stackViewButton.spacing = 20
        stackView.addArrangedSubview(stackViewButton)
        
    }
    
    private func addEmailButton() {
        emailButton.setImage(UIImage(named: "email" ), for: .normal)
        stackViewButton.addArrangedSubview(emailButton)
    }
    
    private func addFaceBookButton() {
        facebookButton.setImage(UIImage(named: "facebook" ), for: .normal)
        stackViewButton.addArrangedSubview(facebookButton)
        
    }
    
    private func addGoogleButton() {
        googleButton.setImage(UIImage(named: "google" ), for: .normal)
        stackViewButton.addArrangedSubview(googleButton)
        
    }
    

    
    private func addSignInLabel() {
        signInLabel.text = "Sign In"
        signInLabel.font = UIFont.boldSystemFont(ofSize: 20)
        signInLabel.textColor = #colorLiteral(red: 0.9568627451, green: 0.937254902, blue: 0.937254902, alpha: 1)
        stackView.addArrangedSubview(signInLabel)
        
    }
    
    
    // MARK: - Actions
    
    private func addTargets(){
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func emailButtonTapped() {
        delegate?.emailTappedButton()

    }
    
    @objc private func facebookButtonTapped() {
        delegate?.facebookTappedButton()
      
    }
    
    @objc private func googleButtonTapped() {
        delegate?.googleTappedButton()
       
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
