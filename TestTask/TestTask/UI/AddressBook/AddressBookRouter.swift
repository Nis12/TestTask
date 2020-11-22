//
//  AddressBookRouter.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import UIKit

protocol AddressBookRouterProtocol {
	func showInfo(contact: ContactModel)
}

class AddressBookRouter: AddressBookRouterProtocol {

	private let viewController: UIViewController

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func showInfo(contact: ContactModel) {
		let contactInfoViewController = ContactInfoBuilder().build(contact: contact)
		viewController.navigationController?.present(contactInfoViewController, animated: true)
	}
}
