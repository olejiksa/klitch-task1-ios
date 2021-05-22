//
//  ChatDetailViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 23.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

final class ChatDetailViewController: UIViewController {

	@IBOutlet private weak var messageField: UITextField!
	@IBOutlet private weak var sendButton: LoadingButton!

	private let name: String?

	init(name: String?) {
		self.name = name
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        title = name ?? "Чат"
    }

	@IBAction private func didSend() {
		let alert = AlertHelper.error("Пока не готово...")
		present(alert, animated: true)
	}

	@IBAction private func didEditingChange() {
		let text = messageField.text ?? ""
		sendButton.isEnabled = !text.isEmpty
	}
}
