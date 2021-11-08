//
//  DTO.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 19.10.2021.
//

import Foundation
import SQLite

enum Status: String, CaseIterable {
	case waiting
	case accepted
	case declined
}

enum Gender: String, CaseIterable {
	case male
	case female
	case undefined
}

enum TableType: String, CaseIterable {
	case players, users, app_users, organizers, companies
	case fide_ratings, russian_ratings
	case participations, tournaments, restrictions, tours, games
}

struct Tournament {
	let id: Int64?
	let restrictionId: Int64
	let title: String
	let location: String?
	let openDate: Date
	let closeDate: Date?

	struct DTO {
		let id = Expression<Int64>("id")
		let restrictionId = Expression<Int64>("restriction_id")
		let title = Expression<String>("title")
		let location = Expression<String?>("location")
		let openDate = Expression<Date>("open_date")
		let closeDate = Expression<Date?>("close_date")
	}
}

struct Restriction {
	let id: Int64?
	let minRating: Int64?
	let maxRating: Int64?
	let minAge: Int64?
	let maxAge: Int64?
	let gender: Gender?
	let deadlineDate: Date

	struct DTO {
		let id = Expression<Int64>("id")
		let minRating = Expression<Int64?>("min_rating")
		let maxRating = Expression<Int64?>("max_rating")
		let minAge = Expression<Int64?>("min_age")
		let maxAge = Expression<Int64?>("max_age")
		let gender = Expression<String?>("gender")
		let deadlineDate = Expression<Date>("deadline_date")
	}
}


