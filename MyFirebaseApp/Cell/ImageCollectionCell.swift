//
//  SearchCell.swift
//  RealmTestProject
//
//  Created by rasl on 17.11.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

protocol ImageCollectionDelegare: class {
    func selectedSaveImage(at index: Int)
}

class ImageCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageCollectionCell"
    
    let containerViewFirst = UIView()
    let containerViewSecond = UIView()
    let imagePixabay = UIImageView()
    let likeImage = UIImageView()
    let likeLabel = UILabel()
    let stackView = UIStackView()
    let selectionImage = UIImageView()

    var isSelect = false
    var delegate: ImageCollectionDelegare?
    var index: Int!
    
//    var image: Image? {
//        didSet {
//            configure(image)
//        }
//    }
    
    var pixabayImage: PixabayImage? {
        didSet {
            configure(pixabayImage)
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            selectionImage.isUserInteractionEnabled = false
            selectionImage.isHidden = !isEditing
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addContainerViewFirst()
        addContainerViewSecond()
        addImagePixabay()
        addStackView()
        addLikeImage()
        addSelectionImage()
        addTargets()
   
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        likeLabel.text = ""
        imagePixabay.image = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedCorners()
    }
    
    override var isSelected: Bool {
        didSet {
            
            if isEditing {
                selectionImage.image = isSelected ? UIImage(named: "checked") : UIImage(named: "unchecked")
            }
        }
    }
    
    private func addSelectionImage() {
        selectionImage.translatesAutoresizingMaskIntoConstraints = false
        selectionImage.image = UIImage(named: "unchecked")
        selectionImage.contentMode = .scaleToFill
        containerViewSecond.addSubview(selectionImage)
        
        selectionImage.topAnchor.constraint(equalTo: containerViewSecond.topAnchor, constant: 10).isActive = true
        selectionImage.rightAnchor.constraint(equalTo: containerViewSecond.rightAnchor, constant: -6).isActive = true
        selectionImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        selectionImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    private func addContainerViewFirst() {
        containerViewFirst.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(containerViewFirst)
        
        containerViewFirst.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerViewFirst.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerViewFirst.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerViewFirst.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    private func addContainerViewSecond() {
        containerViewSecond.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        containerViewFirst.addSubview(containerViewSecond)
        
        containerViewSecond.topAnchor.constraint(equalTo: containerViewFirst.topAnchor).isActive = true
        containerViewSecond.leftAnchor.constraint(equalTo: containerViewFirst.leftAnchor).isActive = true
        containerViewSecond.rightAnchor.constraint(equalTo: containerViewFirst.rightAnchor).isActive = true
        containerViewSecond.bottomAnchor.constraint(equalTo: containerViewFirst.bottomAnchor).isActive = true
        
    }
    
    private func addImagePixabay() {
        imagePixabay.translatesAutoresizingMaskIntoConstraints = false
        imagePixabay.contentMode = .scaleAspectFill
        containerViewSecond.addSubview(imagePixabay)
        
        imagePixabay.topAnchor.constraint(equalTo: containerViewSecond.topAnchor).isActive = true
        imagePixabay.leftAnchor.constraint(equalTo: containerViewSecond.leftAnchor).isActive = true
        imagePixabay.rightAnchor.constraint(equalTo: containerViewSecond.rightAnchor).isActive = true
        imagePixabay.bottomAnchor.constraint(equalTo: containerViewSecond.bottomAnchor).isActive = true
        
        
    }
    
    private func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.distribution = .fill
        stackView.alignment = .fill
        containerViewSecond.addSubview(stackView)
        
        stackView.rightAnchor.constraint(equalTo: containerViewFirst.rightAnchor, constant: -6).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerViewFirst.bottomAnchor, constant: -4).isActive = true
        
    }
    
    private func addLikeImage() {
        likeImage.translatesAutoresizingMaskIntoConstraints = false
        likeImage.contentMode = .scaleAspectFit
        likeImage.image = UIImage(named: "like")
        stackView.addArrangedSubview(likeImage)
        
        likeImage.heightAnchor.constraint(equalToConstant: 13).isActive = true
        likeImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
    private func addLikeLabel() {
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        likeLabel.text = "10000"
        likeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        stackView.addArrangedSubview(likeLabel)
        
    }
    
    // MARK: - Actions
    
    private func addTargets() {
        selectionImage.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(addButtonPressed)))
        selectionImage.isUserInteractionEnabled = true
    }
    
    @objc private func addButtonPressed(_ sender: UIButton) {
        if let index = index {
            selectionImage.image = UIImage(named: "checked")
            delegate?.selectedSaveImage(at: index)
        }
    }
    
    private func configure(_ image: PixabayImage?) {
        guard let image = image else { return }
        likeLabel.text = String(image.likes)
        imagePixabay.setImage(fromString: image.webformatURL, placeholder: UIImage(named: "logo_square"))
        
        
    }
    
//    fileprivate func configure(_ image: Image?) {
//        guard let image = image else { return }
//        likeLabel.text = String(image.likes)
//        imagePixabay.setImage(fromString: image.webformatURL, placeholder: UIImage(named: "logo_square"))
//
//    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ImageCollectionCell {
    private func roundedCorners() {
        containerViewFirst.layer.cornerRadius = 9
        containerViewFirst.layer.shadowOpacity = 0.70
        containerViewFirst.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerViewFirst.layer.shadowRadius = 5
        
        containerViewSecond.layer.cornerRadius = 9
        containerViewSecond.clipsToBounds = true
        
    }
}
