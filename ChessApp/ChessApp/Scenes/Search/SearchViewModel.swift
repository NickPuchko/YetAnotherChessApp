//
//  SearchViewModel.swift
//  SearchViewModel
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
	private unowned let searchCoordinator: SearchCoordinator
	@Published private var events: [EventState]
	@Published var startDate: Date
	@Published var endDate: Date
	@Published var isSearching: Bool
	@Published var searchString: String

	init(searchCoordinator: SearchCoordinator) {
		self.searchCoordinator = searchCoordinator
		events = [] // TODO: restore form storage
		startDate = Date()
		endDate = .distantFuture
		isSearching = false
		searchString = ""

		provideMockData()
	}

	var filteredEvents: [EventState] {
		events.filter {
			isSearching ?
			$0.isFound(searchString)
			&& $0.startDate >= startDate
			&& $0.endDate <= endDate
			: true
		}
	}

	func openDetailed(event: EventState) {
		searchCoordinator.openDetailed(event: event)
	}

	private func provideMockData(completion: (() -> ())? = nil) {
		events = [
			EventState(
				id: 0,
				title: "Aeroflot open",
				location: "Moscow",
				imageData: UIImage(systemName: "paperplane.circle"),
				startDate: Date(timeIntervalSinceNow: 100_000),
				endDate: Date(timeIntervalSinceNow: 200_000),
				ratingType: .fide,
				mode: .classic
			),
			EventState(
				id: 1,
				title: "Aeroflot open 2",
				location: "Moscow 2",
				imageData: UIImage(systemName: "paperplane.circle"),
				startDate: Date(timeIntervalSinceNow: 200_000),
				endDate: Date(timeIntervalSinceNow: 300_000),
				ratingType: .frc,
				mode: .rapid
			),
			EventState(
				id: 2,
				title: "Aeroflot open 3",
				location: "Moscow 3",
				imageData: UIImage(systemName: "paperplane.circle"),
				startDate: Date(timeIntervalSinceNow: 400_000),
				endDate: Date(timeIntervalSinceNow: 600_000),
				ratingType: .frc,
				mode: .classic
			),
			EventState(
				id: 3,
				title: "Aeroflot open 4",
				location: "Moscow 4",
				imageData: UIImage(systemName: "paperplane.circle"),
				startDate: Date(timeIntervalSinceNow: 700_000),
				endDate: Date(timeIntervalSinceNow: 900_000),
				ratingType: .fide,
				mode: .classic
			)
		]
	}
}
