//
//  SceneDelegate.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.6145308614, green: 0.6974866986, blue: 1, alpha: 1)
		UINavigationBar.appearance().tintColor = .white
		UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.6145308614, green: 0.6974866986, blue: 1, alpha: 1)
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

		window = UIWindow(windowScene: windowScene)
		let vc = AuthViewController()
		let nvc = UINavigationController(rootViewController: vc)
		window?.rootViewController = nvc
		window?.makeKeyAndVisible()
	}
}
