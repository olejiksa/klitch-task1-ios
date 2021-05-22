//
//  KlitchType.swift
//  Klitch
//
//  Created by Oleg Samoylov on 23.05.2021.
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Foundation

enum KlitchType: String, Codable {
	case community
	case help
	case project
	case neighbor

	init(number: Int) {
		switch number {
		case 1: self = .help
		case 2: self = .project
		case 3: self = .neighbor
		default: self = .community
		}
	}
}
