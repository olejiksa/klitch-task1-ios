//
//  AlertHelper.swift
//  Klitch
//
//  Created by Oleg Samoylov on 22.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import UIKit

final class AlertHelper {

	static func alert(_ message: String) -> UIAlertController {
		let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
		alert.addAction(.init(title: "ОК", style: .default, handler: nil))
		return alert
	}
}
