//
//  ContactInfoBuilder.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

class ContactInfoBuilder {
	func build(contact: ContactModel) -> ContactInfoViewController {
		let presenter = ContactInfoPresenter(contact: contact)
		let viewController = ContactInfoViewController(presenter: presenter)

		return viewController
	}
}
