//
//  NewKlitchViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Firebase
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
	private var firestore: Firestore?

	private var user: User? { Auth.auth().currentUser }

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
		title = "Новый клич"

		placeholderView.contentMode = .scaleAspectFill
		placeholderView.clipsToBounds = true
		placeholderView.layer.cornerRadius = 100

		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 100

		imagePicker = ImagePicker(presentationController: self, delegate: self)
	}

	private func setupData() {
		firestore = Firestore.firestore()

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
			giveHelpLabel.isHidden = true
			giveHelpField.isHidden = true
		}
	}

	@IBAction private func didCreateKlitch() {
		guard let getHelp = getHelpField.text, let giveHelp = giveHelpField.text else { return }

		_ = firestore?.collection("klitches").addDocument(data: [
			"getHelp": getHelp,
			"giveHelp": giveHelp,
			"type": klitchType.rawValue
		])

		let alert = AlertHelper.success("Клич успешно создан!") {
			self.navigationController?.popViewController(animated: true)
		}
		
		present(alert, animated: true)
	}
}

extension NewKlitchViewController: ImagePickerDelegate {

	func didSelect(image: UIImage?) {
		guard let image = image else { return }
		imageView.image = image
	}
}
