//
//  Search.swift
//  Search
//
//  Created by Nikolai Puchko on 11.09.2021.
//

import SwiftUI
import Combine

struct Search: View {
	@State var isSearching: Bool = false
	@State var searchString: String
	@State var startDate: Date
	@State var endDate: Date
	let events: [EventState]

    var body: some View {
		NavigationView {
			VStack {
				if isSearching {
					SearchBar(text: $searchString, isSearching: $isSearching)
						.padding()
					Filters(startDate: $startDate, endDate: $endDate)
						.padding()
				}
				ScrollView {
					LazyVStack(spacing: 0) {
						ForEach(events.filter {
							isSearching ?
							$0.isFound(searchString)
							&& $0.startDate >= startDate
							&& $0.endDate <= endDate
							: true }
						) { event in
							EventPreview(eventState: event)
						}
					}
					.id(UUID())
					.navigationTitle("Лента")
					.navigationBarTitleDisplayMode(.inline)
					.toolbar {
						ToolbarItem(placement: .navigationBarTrailing) {
							Button {
								withAnimation {
									isSearching = !isSearching
								}
							} label: {
								Config.lupa.resizable()
							}
						}
						ToolbarItem(placement: .navigationBarLeading) {
							Button {
								//
							} label: {
								Config.pupa.resizable()
							}

						}
					}
				}
			}
		}
    }
}

extension Search {
	struct Config {
		static let lupa = Image(systemName: "text.magnifyingglass")
		static let pupa = Image(systemName: "bookmark")
	}
}

struct Search_Previews: PreviewProvider {
	static let mockEvents = [
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
    static var previews: some View {
		Search(
			searchString: "",
			startDate: Date(),
			endDate: Date(timeIntervalSinceNow: 300_000),
			events: mockEvents
		)
    }
}
