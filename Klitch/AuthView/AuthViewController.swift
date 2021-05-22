//
//  AuthViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Firebase
import UIKit

final class AuthViewController: UIViewController {

	@IBOutlet private weak var emailField: UITextField!
	@IBOutlet private weak var passwordField: UITextField!
	@IBOutlet private weak var logInButton: LoadingButton!
	@IBOutlet private weak var isOrganizerSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Авторизация"

		#if DEBUG
		passwordField.isSecureTextEntry = false
		#endif
    }

	@IBAction private func didSignUpButtonTap() {
		let vc = SignUpViewController()
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction private func didAuthorizeTap() {
		guard let email = emailField.text,
			  let password = passwordField.text else { return }

		logInButton.showLoading()

		Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
			guard let self = self else { return }

			self.logInButton.hideLoading()

			if let error = error {
				let alert = AlertHelper.alert(error.localizedDescription)
				self.present(alert, animated: true)
			} else if let authResult = authResult {
				let vc = MainViewController(user: authResult.user)
				self.clearBackStack(with: vc)
				let keyedUser = try? NSKeyedArchiver.archivedData(withRootObject: authResult.user, requiringSecureCoding: false)
				UserDefaults.standard.setValue(keyedUser, forKey: "user")
			}
		}
	}

	private func clearBackStack(with viewController: UIViewController) {
		if let window = UIApplication.shared.windows.first {
			let nvc = UINavigationController(rootViewController: viewController)
			window.rootViewController = nvc
			nvc.popToRootViewController(animated: false)
		}
	}
}
