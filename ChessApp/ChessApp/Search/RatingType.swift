//
//  RatingType.swift
//  RatingType
//
//  Created by Nikolai Puchko on 11.09.2021.
//

import SwiftUI

enum RatingType: String, Codable, CaseIterable, Identifiable {
	var id: Int {
		switch self {
		case .fide: return 0
		case .frc: return 1
		case .without: return 2
		}
	}

	case fide, frc, without

	var image: Image {
		Image(self.rawValue, bundle: .main)
	}

	var description: String {
		switch self {
		case .fide: return "FIDE"
		case .frc: return "ФШР"
		case .without: return "Без обсчёта рейтинга"
		}
	}
}
