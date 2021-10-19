//
//  DetailedEventViewModel.swift
//  DetailedEventViewModel
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import Foundation
import Combine

final class DetailedEventViewModel: ObservableObject {
	@Published var eventState: EventState
	private unowned let searchCoordinator: SearchCoordinator

	init(eventState: EventState, searchCoordinator: SearchCoordinator) {
		self.eventState = eventState
		self.searchCoordinator = searchCoordinator
	}
}

struct Player: Codable, Identifiable {
	let id: String
	let fullname: String
	let ratings: Ratings
}

struct EventDetails: Codable, Identifiable {
	let id: String
	let numberOfGames: Int
	let averageRating: Int
	let fee: Int
	let prizePool: Int
	let gameMode: GameMode
	let statementURL: URL?
}

enum GameMode: Codable {
	case classic(TimeControl)
	case rapid(TimeControl)
	case blitz(TimeControl)
	case bullet(TimeControl)
	case unknown(TimeControl)

	init(_ timeControl: TimeControl) {
		switch timeControl.totalTime {
		case 60...180:
			self = .bullet(timeControl)
		case 181...600:
			self = .blitz(timeControl)
		case 601..<3600:
			self = .rapid(timeControl)
		case 3600...:
			self = .classic(timeControl)
		default:
			self = .unknown(timeControl)
		}
	}

	var description: String {
		switch self {
		case .classic:
			return "Классика"
		case .rapid:
			return "Рапид"
		case .blitz:
			return "Блиц"
		case .bullet:
			return "Пуля"
		case .unknown:
			return "Неизвестный режим"
		}
	}
}

struct TimeControl: Codable {
	let minutes: Int
	let seconds: Int
	let increment: Int

	var totalTime: Int {
		60 * (minutes + increment) + seconds
	}
}
