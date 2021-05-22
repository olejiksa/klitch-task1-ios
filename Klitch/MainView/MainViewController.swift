//
//  MainViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Firebase
import UIKit

final class MainViewController: UIViewController {

	@IBOutlet private weak var statusLabel: UILabel!

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

        title = "Статус"
		let text = statusLabel.text ?? ""
		statusLabel.text = "\(text) \(user.email ?? "")"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выйти",
															style: .plain,
															target: self,
															action: #selector(didLogOutTap))
    }

	@objc private func didLogOutTap() {
		let vc = AuthViewController()
		clearBackStack(with: vc)
	}

	private func clearBackStack(with viewController: UIViewController) {
		if let window = UIApplication.shared.windows.first {
			let nvc = UINavigationController(rootViewController: viewController)
			window.rootViewController = nvc
			nvc.popToRootViewController(animated: false)
		}
	}
}
