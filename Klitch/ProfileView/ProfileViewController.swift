//
//  ProfileViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 23.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Firebase
import UIKit

final class ProfileViewController: UIViewController {

	@IBOutlet private weak var emailLabel: UILabel!
	@IBOutlet private weak var nameField: UITextField!
	@IBOutlet private weak var descriptionField: UITextField!
	@IBOutlet private weak var saveButton: LoadingButton!

	private var user: User? { Auth.auth().currentUser }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Профиль"
		emailLabel.text = "\(emailLabel.text ?? "") \(user?.email ?? "")"

		setData()
    }

	@IBAction private func save() {
		saveButton.showLoading()

		let request = user?.createProfileChangeRequest()
		request?.displayName = nameField.text
		request?.commitChanges { [weak self] error in
			guard let self = self else { return }

			self.saveButton.hideLoading()

			let alert: UIAlertController
			if let error = error {
				alert = AlertHelper.error(error.localizedDescription)
			} else {
				alert = AlertHelper.success("Профиль успешно обновлен!") {
					self.navigationController?.popViewController(animated: true)
				}

				self.setData()
			}

			self.present(alert, animated: true)
		}
	}

	private func setData() {
		nameField.text = user?.displayName
	}
}
