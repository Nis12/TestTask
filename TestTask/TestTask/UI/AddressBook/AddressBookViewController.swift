//
//  ViewController.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import UIKit

class AddressBookViewController: UIViewController, UITableViewDelegate {

	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .singleLine
		tableView.tableFooterView = UIView()
		tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")

		return tableView
	}()

	private let presenter: AddressBookPresenterProtocol

	init(presenter: AddressBookPresenterProtocol) {
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
		navigationItem.title = "Адресная кника"
		setupTableView()
	}

	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

extension AddressBookViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.contactArray?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell,
			  let contacts = presenter.contactArray,
			  !contacts.isEmpty else {
			return UITableViewCell()
		}

		let contact = contacts[indexPath.row]
		cell.setup(contact: contact)

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.showContact(index: indexPath.row)
	}
}
