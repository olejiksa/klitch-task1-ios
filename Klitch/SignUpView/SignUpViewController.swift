//
//  SignUpViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Firebase
import UIKit

final class SignUpViewController: UIViewController {

	@IBOutlet private weak var emailField: UITextField!
	@IBOutlet private weak var passwordField: UITextField!
	@IBOutlet private weak var repeatPasswordField: UITextField!
	@IBOutlet private weak var isOrganizerSwitch: UISwitch!
	@IBOutlet private weak var signUpButton: LoadingButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Регистрация"

		#if DEBUG
		passwordField.isSecureTextEntry = false
		repeatPasswordField.isSecureTextEntry = false
		#endif
    }

	@IBAction private func didSignUpButtonTap() {
		guard let email = emailField.text,
			  let password = passwordField.text,
			  let repeatPassword = repeatPasswordField.text else { return }

		guard password == repeatPassword else {
			let alert = AlertHelper.error("Пароли должны совпадать")
			present(alert, animated: true)
			return
		}

		signUpButton.showLoading()

		Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
			guard let self = self else { return }

			self.signUpButton.hideLoading()

			if let error = error {
				let alert = AlertHelper.error(error.localizedDescription)
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
