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

	@IBOutlet private weak var searchButton: LoadingButton!

	private var firestore: Firestore?
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

	@IBAction private func didSuggestHelp() {
		searchButton.showLoading()

		firestore?.collection("klitches").getDocuments() { [weak self] querySnapshot, err in
			guard let self = self else { return }

			self.searchButton.hideLoading()

			if let err = err {
				let alert = AlertHelper.error(err.localizedDescription)
				self.present(alert, animated: true)
			} else {
				var klitches: [KlitchModel] = []
				for document in querySnapshot?.documents ?? [] {
					let data = document.data()
					let name = data["name"] as? String ?? ""
					let description = data["description"] as? String ?? ""
					let getHelp = data["getHelp"] as? String ?? ""
					let giveHelp = data["giveHelp"] as? String ?? ""
					let categories = data["categories"] as? String ?? ""
					let type = KlitchType(rawValue: data["type"] as? String ?? "") ?? .community
					klitches.append(.init(name: name,
										  categories: categories,
										  description: description,
										  getHelp: getHelp,
										  giveHelp: giveHelp,
										  type: type))
				}

				if !klitches.isEmpty {
					let vc = KlitchDetailViewController(klitches: klitches)
					self.navigationController?.pushViewController(vc, animated: true)
				} else {
					let alert = AlertHelper.error("Пока нет клитчей в базе данных. Попробуйте создать первый!")
					self.present(alert, animated: true)
				}
			}
		}
	}

	private func setupData() {
		title = "Меню"
		
		firestore = Firestore.firestore()
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
