//
//  ContactInfoPresenter.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import Foundation

protocol ContactInfoPresenterProtocol {
	var contact: ContactModel { get }
}

class ContactInfoPresenter: ContactInfoPresenterProtocol {

	var contact: ContactModel

	init(contact: ContactModel) {
		self.contact = contact
	}
}
