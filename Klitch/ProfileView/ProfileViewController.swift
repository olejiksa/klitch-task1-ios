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

	private let user: User

	init(user: User) {
		self.user = user
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Профиль"
		let text = emailLabel.text ?? ""
		emailLabel.text = "\(text) \(user.email ?? "")"
    }

	@IBAction private func save() {
		let alert = AlertHelper.success("Профиль успешно обновлен!") {
			self.navigationController?.popViewController(animated: true)
		}

		present(alert, animated: true)
	}
}
