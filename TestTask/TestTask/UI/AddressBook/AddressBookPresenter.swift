//
//  AddressBookPresenter.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import Foundation
import ContactsUI

protocol AddressBookPresenterProtocol {
	var contactArray: [ContactModel]? { get }

	func showContact(index: Int)
}

class AddressBookPresenter: AddressBookPresenterProtocol {

	var contactArray: [ContactModel]?

	private var router: AddressBookRouterProtocol?

	init() {
		contactArray = getContacts()
	}

	func setup(router: AddressBookRouterProtocol) {
		self.router = router
	}

	func showContact(index: Int) {
		router?.showInfo(contact: contactArray![index])
	}

	private func getContacts() -> [ContactModel]? {
		let contactStore = CNContactStore()
		let keysToFetch = [
			CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
			CNContactPhoneNumbersKey,
			CNContactThumbnailImageDataKey
		] as [Any]

		var allContainers: [CNContainer] = []
		do {
			allContainers = try contactStore.containers(matching: nil)
		} catch {
			print("Error fetching containers")

			return nil
		}

		var contacts: [CNContact] = []

		for container in allContainers {
			let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
			do {
				let containerResults = try contactStore.unifiedContacts(
					matching: fetchPredicate,
					keysToFetch: keysToFetch as! [CNKeyDescriptor]
				)

				contacts.append(contentsOf: containerResults)
			} catch {
				print("Error fetching containers")

				return nil
			}
		}

		return contacts.map { (contact) -> ContactModel in

			let image = contact.thumbnailImageData == nil ? UIImage(named: "empty_image") : UIImage(data: contact.thumbnailImageData ?? Data())
			let name = "\(contact.familyName) \(contact.givenName) \(contact.middleName)"

			return .init(avatar: image ?? UIImage(), name: name, phoneNumbers: contact.phoneNumbers)
		}
	}
}
