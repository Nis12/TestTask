//
//  ContactInfoViewController.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import UIKit

private struct Constants {
	static let avatarImageViewHeight: CGFloat = UIScreen.main.bounds.width / 3 * 2
	static let nameLabelHeight: CGFloat = 25
	static let nameLabelEdge: CGFloat = 15
	static let tableViewEdge: CGFloat = 10
	static let tableViewHeaderEdge: CGFloat = 5
}

class ContactInfoViewController: UIViewController, UITableViewDelegate {

	private let nameLabel = UILabel()
	private let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
		imageView.contentMode = .scaleAspectFit

		return imageView
	}()

	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.isPagingEnabled = true
		tableView.tableFooterView = UIView()

		tableView.register(PhoneNumberCell.self, forCellReuseIdentifier: "PhoneNumberCell")

		return tableView
	}()

	private let presenter: ContactInfoPresenterProtocol

	init(presenter: ContactInfoPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	private func setupUI() {
		view.backgroundColor = .white
		setupAvatarImageView()
		setupNameLabel()
		setupTableView()
	}

	private func setupAvatarImageView() {
		avatarImageView.image = presenter.contact.avatar
		view.addSubview(avatarImageView)
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
			avatarImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
			avatarImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
			avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarImageViewHeight),
		])
	}

	private func setupNameLabel() {
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.text = presenter.contact.name
		view.addSubview(nameLabel)
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,
										   constant: Constants.nameLabelEdge),
			nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: Constants.nameLabelEdge),
			nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.nameLabelEdge),
			nameLabel.heightAnchor.constraint(equalToConstant: Constants.nameLabelHeight),
		])
	}

	private func setupTableView() {
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.tableViewEdge),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: Constants.tableViewEdge),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.tableViewEdge),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = .white

		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Телефонные номера: "
		
		view.addSubview(label)

		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.tableViewHeaderEdge),
			label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.tableViewHeaderEdge)
		])

		return view
	}
}

extension ContactInfoViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.contact.phoneNumbers.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneNumberCell", for: indexPath) as? PhoneNumberCell,
			  !presenter.contact.phoneNumbers.isEmpty else {
			return UITableViewCell()
		}

		cell.setup(phoneNumber: presenter.contact.phoneNumbers[indexPath.row].value.stringValue)

		return cell
	}
}
