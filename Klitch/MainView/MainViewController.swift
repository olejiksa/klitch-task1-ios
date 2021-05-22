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

	private var user: User? { Auth.auth().currentUser }

	override func viewDidLoad() {
        super.viewDidLoad()

		setupData()
        setupNavigationBarButtons()
    }

	@objc private func didLogOutTap() {
		let vc = AuthViewController()
		clearBackStack(with: vc)
		try? Auth.auth().signOut()
	}

	@objc private func didProfileTap() {
		let vc = ProfileViewController()
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc private func didChatListTap() {
		let vc = ChatsListViewController()
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
		let klitchType = KlitchType(number: sender.tag)
		let vc = NewKlitchViewController(klitchType: klitchType)
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction private func didSuggestHelp(_ sender: UIButton) {
		let klitchType = KlitchType(number: sender.tag)
		let klitches: [KlitchModel] = [.init(getHelp: "Нам нужны люди настоящего писательского мастерства",
											 giveHelp: "Станешь частью большой команды",
											 type: klitchType),
									   .init(getHelp: "Я маломобилен",
											 giveHelp: "Удовлетворенность от выполненного дела",
											 type: klitchType),
									   .init(getHelp: "Нам нужны в команду разработчики",
											 giveHelp: "Станешь частью большой команды",
											 type: klitchType),
									   .init(getHelp: "Ищу соседку",
											 giveHelp: "nil",
											 type: klitchType)]
		let vc = KlitchDetailViewController(klitches: klitches)
		navigationController?.pushViewController(vc, animated: true)
	}

	private func setupData() {
		title = "Меню"
	}

	private func setupNavigationBarButtons() {
		navigationItem.leftBarButtonItems = [.init(image: UIImage(systemName: "person.crop.circle.fill"),
												   style: .plain,
												   target: self,
												   action: #selector(didProfileTap)),
											 .init(title: "Чаты",
												   style: .plain,
												   target: self,
												   action: #selector(didChatListTap))]
		navigationItem.rightBarButtonItem = .init(title: "Выйти",
												  style: .plain,
												  target: self,
												  action: #selector(didLogOutTap))
	}
}
