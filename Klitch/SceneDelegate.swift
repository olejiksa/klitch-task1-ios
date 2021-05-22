//
//  SceneDelegate.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Firebase
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.6145308614, green: 0.6974866986, blue: 1, alpha: 1)
		UINavigationBar.appearance().tintColor = .white
		UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.6145308614, green: 0.6974866986, blue: 1, alpha: 1)
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

		UITextField.appearance().layer.borderWidth = 3
		UITextField.appearance().layer.borderColor = UIColor.black.cgColor
		UITextField.appearance().backgroundColor = #colorLiteral(red: 0.7099748254, green: 0.8300378919, blue: 0.9915148616, alpha: 1)

		window = UIWindow(windowScene: windowScene)

		let vc: UIViewController
		let keyedUser = UserDefaults.standard.value(forKey: "user") as? Data
		let user = keyedUser.map { try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [User.self], from: $0) } as? User
		if let user = user {
			vc = MainViewController(user: user)
		} else {
			vc = AuthViewController()
		}

		let nvc = UINavigationController(rootViewController: vc)
		window?.rootViewController = nvc
		window?.makeKeyAndVisible()
	}
}
