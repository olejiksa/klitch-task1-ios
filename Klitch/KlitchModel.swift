//
//  KlitchModel.swift
//  Klitch
//
//  Created by Oleg Samoylov on 23.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

struct KlitchModel: Codable {
	let name: String
	let categories: String
	let description: String
	let getHelp: String
	let giveHelp: String?
	let type: KlitchType
}
