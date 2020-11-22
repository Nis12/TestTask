//
//  PhoneNumberCell.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import UIKit

private struct Constants {
	static let generalEdge: CGFloat = 5
	static let heightLabel: CGFloat = 30
}

class PhoneNumberCell: UITableViewCell {

	private let phoneNumberLabel = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setup(phoneNumber: String) {
		phoneNumberLabel.text = phoneNumber
	}

	private func setupUI() {
		selectionStyle = .none
		setupPhoneNumber()
	}

	private func setupPhoneNumber() {
		phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(phoneNumberLabel)
		NSLayoutConstraint.activate([
			phoneNumberLabel.heightAnchor.constraint(equalToConstant: Constants.heightLabel),
			phoneNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.generalEdge),
			phoneNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.generalEdge),
			phoneNumberLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.generalEdge),
			phoneNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.generalEdge)
		])
	}
}
