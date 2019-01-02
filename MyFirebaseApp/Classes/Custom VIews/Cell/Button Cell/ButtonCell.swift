//
//  ButtonCell.swift
//  MyFirebaseApp
//
//  Created by rasl on 23.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
	static let reuseIdentifier = "ButtonCell"
	
	private let buttonView = ButtonView()
	
	var saveButtonViewClicked: VoidClosure? {
		didSet {
			buttonView.saveButtonClicked = saveButtonViewClicked
		}
	}
	
	var logOutButtonViewClicked: VoidClosure? {
		didSet {
			buttonView.logOutButtonClicked = logOutButtonViewClicked
		}
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		Decorator.decorate(cell: self)
		addButtonView()
		
	}
	
	private func addButtonView() {
		buttonView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(buttonView)
		
		buttonView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		buttonView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		buttonView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		buttonView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension ButtonCell {
	fileprivate class Decorator {
		static func decorate(cell: ButtonCell) {
			cell.selectionStyle = .none
			cell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
			
		}
	}
}
