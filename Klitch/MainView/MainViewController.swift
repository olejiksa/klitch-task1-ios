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

		setupData()
        setupNavigationBarButtons()
    }

	@objc private func didLogOutTap() {
		let vc = AuthViewController()
		clearBackStack(with: vc)
	}

	@objc private func didProfileTap() {
		let vc = ProfileViewController(user: user)
		navigationController?.pushViewController(vc, animated: true)
	}

	private func clearBackStack(with viewController: UIViewController) {
		if let window = UIApplication.shared.windows.first {
			let nvc = UINavigationController(rootViewController: viewController)
			window.rootViewController = nvc
			nvc.popToRootViewController(animated: false)
		}
	}

	@IBAction private func didAsk(_ sender: UIButton) {
		let klitchType = KlitchType(rawValue: sender.tag)
		let vc = klitchType.map(NewKlitchViewController.init)
		vc.map { navigationController?.pushViewController($0, animated: true) }
	}

	@IBAction private func didSuggestHelp(_ sender: UIButton) {
		let klitchType = KlitchType(rawValue: sender.tag)
		let vc = klitchType.map(KlitchDetailViewController.init)
		vc.map { navigationController?.pushViewController($0, animated: true) }
	}

	private func setupData() {
		title = "Меню"
	}

	private func setupNavigationBarButtons() {
		navigationItem.leftBarButtonItem = .init(image: UIImage(systemName: "person.crop.circle.fill"),
												 style: .plain,
												 target: self,
												 action: #selector(didProfileTap))
		navigationItem.rightBarButtonItem = .init(title: "Выйти",
												  style: .plain,
												  target: self,
												  action: #selector(didLogOutTap))
	}
}
