//
//  ChatsListViewController.swift
//  Klitch
//
//  Created by Oleg Samoylov on 23.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

final class ChatsListViewController: UIViewController {

	private var chats: [String] = ["mock1", "mock2"]

	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var noDataLabel: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()

        title = "Чаты"

		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")

		tableView.isHidden = chats.isEmpty
		noDataLabel.isHidden = !chats.isEmpty
    }
}

extension ChatsListViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension ChatsListViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		chats.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
		cell.textLabel?.text = "Чат \(indexPath.row + 1)"
		return cell
	}
}
