//
//  ContactCell.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import UIKit

private struct Constants {
	static let imageSize: CGSize = CGSize(width: 40, height: 40)
	static let leftRightEdge: CGFloat = 20
	static let avatarStackViewEdge: CGFloat = 15
	static let topBottomEdge: CGFloat = 5
}

class ContactCell: UITableViewCell {

	private let nameLabel = UILabel()
	private let phoneNumberLabel = UILabel()
	private let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setup(contact: ContactModel) {
		avatarImageView.image = contact.avatar
		nameLabel.text = "Имя: " + contact.name
		phoneNumberLabel.text = "Номер: " + (contact.mainNumber?.value.stringValue ?? "")
	}

	private func setupUI() {
		selectionStyle = .none
		setupAvatarImageView()
		setupNameAndPhoneNumberLabels()
	}

	private func setupAvatarImageView() {
		addSubview(avatarImageView)
		NSLayoutConstraint.activate([
			avatarImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize.width),
			avatarImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize.height),
			avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.leftRightEdge)
		])
	}

	private func setupNameAndPhoneNumberLabels() {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.contentMode = .center
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false

		stackView.addArrangedSubview(nameLabel)
		stackView.addArrangedSubview(phoneNumberLabel)

		addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topBottomEdge),
			stackView.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor,
											constant: Constants.avatarStackViewEdge),
			stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.leftRightEdge),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.topBottomEdge)
		])
	}
}
