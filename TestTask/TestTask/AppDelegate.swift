//
//  AppDelegate.swift
//  TestTask
//
//  Created by  Boris Chechko on 22.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow()
		let navigationVC = UINavigationController()
		window?.rootViewController = navigationVC
		navigationVC.pushViewController(AddressBookBuilder().build(), animated: false)
		window?.makeKeyAndVisible()
		
		return true
	}
}

