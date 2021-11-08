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
	@Published var isFormPresented: Bool

	@Published var title: String
	@Published var location: String
	@Published var openDate: Date
	@Published var closeDate: Date
	@Published var minRating: Int?
	@Published var maxRating: Int?
	@Published var deadlineDate: Date

	private let store: Store

	init(searchCoordinator: SearchCoordinator) {
		self.searchCoordinator = searchCoordinator
		events = [] // TODO: restore form storage
		startDate = Date()
		endDate = .distantFuture
		isSearching = false
		isFormPresented = false
		searchString = ""

		title = ""
		location = ""
		openDate = Date()
		closeDate = Date()
		deadlineDate = Date()
		
		store = Store()
		store.createTables { error in
			NSLog(error?.localizedDescription ?? "Database restored")
		}
//		provideMockData()
		requestEvents()
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

	func requestEvents() {
		store.selectTournaments(
			openDate: startDate, endDate: endDate) { events in
				self.events = events.map {
					return EventState(
						id: Int($0.id ?? 0),
						title: $0.title,
						location: $0.location ?? "",
						imageData: nil,
						startDate: $0.openDate,
						endDate: $0.closeDate ?? Date(),
						ratingType: .without,
						mode: .init(TimeControl(minutes: 15, seconds: 0, increment: 0))
					)
				}
			}
	}

	func createEvent(completion: @escaping (Bool) -> Void) {
		DispatchQueue.global().async {
			if !self.store.isDatabaseReady {
				self.store.createTables { error in
					if error == nil {
						self.requestInsertion(completion: completion)
					}
				}
			}
			self.requestInsertion(completion: completion)
		}
	}

	private func requestInsertion(completion: @escaping (Bool) -> Void) {
		let restriction = Restriction(
			id: nil,
			minRating: Int64(self.minRating ?? 0),
			maxRating: Int64(self.maxRating ?? 0),
			minAge: nil,
			maxAge: nil,
			gender: nil,
			deadlineDate: self.deadlineDate
		)
		self.store.insert(restriction) { id in
			if let id = id {
				let event = Tournament(
					id: nil,
					restrictionId: id,
					title: self.title,
					location: self.location,
					openDate: self.openDate,
					closeDate: self.closeDate
				)
				self.store.insert(event) { id in
					if let eventId = id {
						let state = EventState(
							id: Int(eventId),
							title: event.title,
							location: event.location ?? "",
							imageData: nil,
							startDate: event.openDate,
							endDate: event.closeDate ?? self.closeDate,
							ratingType: .fide,
							mode: .blitz(TimeControl(minutes: 5, seconds: 0, increment: 0))
						)
						NSLog("Created event with id: \(eventId)")
						self.events.append(state)
						onMainThread {
							completion(true)
						}
					} else {
						onMainThread {
							completion(false)
						}
					}
				}
			} else {
				onMainThread {
					completion(false)
				}
			}
		}
	}

	func clearData() {
		store.clearTable(of: nil)
		events = []
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
				mode: .init(.init(minutes: 15, seconds: 0, increment: 0))
			),
			EventState(
				id: 1,
				title: "Aeroflot open 2",
				location: "Moscow 2",
				imageData: UIImage(systemName: "paperplane.circle"),
				startDate: Date(timeIntervalSinceNow: 200_000),
				endDate: Date(timeIntervalSinceNow: 300_000),
				ratingType: .frc,
				mode: .init(.init(minutes: 15, seconds: 0, increment: 0))
			),
			EventState(
				id: 2,
				title: "Aeroflot open 3",
				location: "Moscow 3",
				imageData: UIImage(systemName: "paperplane.circle"),
				startDate: Date(timeIntervalSinceNow: 400_000),
				endDate: Date(timeIntervalSinceNow: 600_000),
				ratingType: .frc,
				mode: .init(.init(minutes: 15, seconds: 0, increment: 0))
			),
			EventState(
				id: 3,
				title: "Aeroflot open 4",
				location: "Moscow 4",
				imageData: UIImage(systemName: "paperplane.circle"),
				startDate: Date(timeIntervalSinceNow: 700_000),
				endDate: Date(timeIntervalSinceNow: 900_000),
				ratingType: .fide,
				mode: .init(.init(minutes: 15, seconds: 0, increment: 0))
			)
		]
	}
}
