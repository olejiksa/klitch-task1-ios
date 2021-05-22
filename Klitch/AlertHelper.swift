//
//  AlertHelper.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

final class AlertHelper {

	static func error(_ message: String) -> UIAlertController {
		let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
		alert.addAction(.init(title: "ОК", style: .default, handler: nil))
		return alert
	}

	static func match(_ message: String, connectHandler: @escaping () -> Void) -> UIAlertController {
		let alert = UIAlertController(title: "Совпадение", message: message, preferredStyle: .alert)
		alert.addAction(.init(title: "Связаться", style: .default) { _ in connectHandler() })
		alert.addAction(.init(title: "Закрыть", style: .cancel, handler: nil))
		return alert
	}
}
