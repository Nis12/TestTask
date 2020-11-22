//
//  AddressBookBuilder.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

class AddressBookBuilder {
	func build() -> AddressBookViewController {
		let presenter = AddressBookPresenter()
		let viewController = AddressBookViewController(presenter: presenter)
		let router = AddressBookRouter(viewController: viewController)
		presenter.setup(router: router)

		return viewController
	}
}
