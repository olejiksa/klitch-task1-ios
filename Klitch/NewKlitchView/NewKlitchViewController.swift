//
//  NewKlitchViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

final class NewKlitchViewController: UIViewController {

	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var placeholderView: UIView!
	@IBOutlet private weak var getHelpLabel: UILabel!
	@IBOutlet private weak var giveHelpLabel: UILabel!
	@IBOutlet private weak var getHelpField: UITextField!
	@IBOutlet private weak var giveHelpField: UITextField!

	private var imagePicker: ImagePicker?
	private let klitchType: KlitchType

	init(klitchType: KlitchType) {
		self.klitchType = klitchType
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		setupUI()
		setupData()
    }

	@IBAction private func didPickerTap(_ sender: UIButton) {
		imagePicker?.present(from: sender)
	}

	private func setupUI() {
		title = "Клич"

		placeholderView.contentMode = .scaleAspectFill
		placeholderView.clipsToBounds = true
		placeholderView.layer.cornerRadius = 100

		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 100

		imagePicker = ImagePicker(presentationController: self, delegate: self)
	}

	private func setupData() {
		switch klitchType {
		case .community, .project:
			getHelpLabel.text = "Расскажи, что умеешь"
			giveHelpLabel.text = "Что ждешь от работы"
			giveHelpLabel.isHidden = false
			giveHelpField.isHidden = false
		case .help:
			getHelpLabel.text = "Расскажи, с чем помочь"
			giveHelpLabel.isHidden = true
			giveHelpField.isHidden = true
		case .neighbor:
			getHelpLabel.text = "Расскажи о себе"
			giveHelpLabel.isHidden = false
			giveHelpField.isHidden = false
		}
	}
}

extension NewKlitchViewController: ImagePickerDelegate {

	func didSelect(image: UIImage?) {
		guard let image = image else { return }
		imageView.image = image
	}
}
