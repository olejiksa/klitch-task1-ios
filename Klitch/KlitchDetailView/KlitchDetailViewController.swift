//
//  KlitchDetailViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 23.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

final class KlitchDetailViewController: UIViewController {

	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var placeholderView: UIView!
	@IBOutlet private weak var getHelpLabel: UILabel!
	@IBOutlet private weak var giveHelpLabel: UILabel!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var getHelpContentLabel: UILabel!
	@IBOutlet private weak var giveHelpContentLabel: UILabel!

	private let klitches: [KlitchModel]
	private var index = 0

	init(klitches: [KlitchModel]) {
		self.klitches = klitches
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Клич"
		
		placeholderView.contentMode = .scaleAspectFill
		placeholderView.clipsToBounds = true
		placeholderView.layer.cornerRadius = 100

		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 100

		navigationItem.rightBarButtonItems = [.init(image: UIImage(systemName: "arrow.up"),
													style: .plain,
													target: self,
													action: #selector(didArrowUpTap)),
											  .init(image: UIImage(systemName: "arrow.down"),
													style: .plain,
													target: self,
													action: #selector(didArrowDownTap))]

		setData()
    }

	@objc private func didArrowUpTap() {
		guard index > 1 else { return }
		index -= 1

		setData()
	}

	@objc private func didArrowDownTap() {
		guard index < klitches.count - 1 else { return }
		index += 1

		setData()
	}

	@objc private func didConnect() {
		let vc = ChatDetailViewController(name: nameLabel.text)
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction private func didMakeChoice() {
		guard index < klitches.count else { return }
		let klitch = klitches[index]

		let message: String
		switch klitch.type {
		case .community:
			message = "Сообщество готово поработать с вами!"
		case .help:
			message = "От вас ждут помощи!"
		case .neighbor:
			message = "Он(а) готов(а) жить с вами!"
		case .project:
			message = "Вы можете стать частью команды!"
		}

		let alert = AlertHelper.match(message, connectHandler: didConnect)
		present(alert, animated: true)
	}

	private func setData() {
		guard index < klitches.count else { return }
		let klitch = klitches[index]
		nameLabel.text = klitch.name
		descriptionLabel.text = klitch.description
		getHelpContentLabel.text = klitch.getHelp
		giveHelpContentLabel.text = klitch.giveHelp
	}
}
