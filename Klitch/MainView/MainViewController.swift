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
		let klitchType = KlitchType(rawValue: sender.tag)
		let vc = klitchType.map(NewKlitchViewController.init)
		vc.map { navigationController?.pushViewController($0, animated: true) }
	}

	@IBAction private func didSuggestHelp(_ sender: UIButton) {
		let klitchType = KlitchType(rawValue: sender.tag) ?? .community
		let klitches: [KlitchModel] = [.init(name: "Интернет-журнал",
											 description: "Университетский интернет-журнал",
											 getHelp: "Нам нужны люди настоящего писательского мастерства",
											 giveHelp: "Станешь частью большой команды",
											 type: klitchType),
									   .init(name: "Помощь с покупками",
											 description: "Человек с ограниченными возможностями",
											 getHelp: "Я маломобилен",
											 giveHelp: "Удовлетворенность от выполненного дела",
											 type: klitchType),
									   .init(name: "Проект разработки Telegram-бота",
											 description: "Университетский интернет-журнал",
											 getHelp: "Нам нужны в команду разработчики",
											 giveHelp: "Станешь частью большой команды",
											 type: klitchType),
									   .init(name: "Лиза, 24",
											 description: "Магистрантка 2 курса",
											 getHelp: "Ищу соседку",
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
