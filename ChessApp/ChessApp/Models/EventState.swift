//
//  EventState.swift
//  EventState
//
//  Created by Nikolai Puchko on 11.09.2021.
//

import Foundation
import UIKit

struct EventState: Identifiable {
	let id: Int
	let title: String
	let location: String
	let imageData: UIImage? // TODO: replace with imageURL & AsyncImage
	let startDate: Date
	let endDate: Date
	let ratingType: RatingType
	let mode: GameMode

	func isFound( _ search: String) -> Bool {
		let lowercasedSearch = search.lowercased()
		return lowercasedSearch.isEmpty
		|| title.lowercased().contains(lowercasedSearch)
		|| location.lowercased().contains(lowercasedSearch)
		|| ratingType.description.lowercased().contains(lowercasedSearch)
		|| mode.rawValue.lowercased().contains(lowercasedSearch)
	}
}
