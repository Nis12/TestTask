//
//  ContactModel.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import UIKit
import ContactsUI

struct  ContactModel {
	let avatar: UIImage
	let name: String
	let phoneNumbers: [CNLabeledValue<CNPhoneNumber>]

	var mainNumber: CNLabeledValue<CNPhoneNumber>? {
		return (phoneNumbers.first { (phoneNumber) -> Bool in
			 phoneNumber.label == CNLabelPhoneNumberMain
		} ?? phoneNumbers.first { (phoneNumber) -> Bool in
			phoneNumber.label == CNLabelPhoneNumberMobile
		}) ?? phoneNumbers.first
	}
}
