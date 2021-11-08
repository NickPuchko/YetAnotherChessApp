//
//  SearchProvider.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 19.10.2021.
//

import Foundation
import SQLite

class TournamentsSearchProvider {
	private let db: Connection
	private lazy var tournaments = VirtualTable(TableType.tournaments.rawValue)
	private lazy var dto = Tournament.DTO()
	private lazy var config = FTS5Config()
		.column(dto.title)
		.column(dto.location, [.unindexed])

	init(db: Connection) {
		self.db = db
		createVirtualTable()
	}

	private func createVirtualTable() {
		do {
			let query = tournaments.create(.FTS5(config), ifNotExists: true)
			try db.run(query)
		} catch {
			NSLog(error.localizedDescription)
		}
	}

	public func extract(
		request: String,
		completion: @escaping ([Tournament]) -> Void
	) {
		do {
			let query = tournaments.filter(tournaments.match("title:*\"\(request)\"*"))
			let mapRowIterator = try db.prepareRowIterator(query)
			let fetchedTournaments = try mapRowIterator.map {
				Tournament(
					id: $0[dto.id],
					restrictionId: $0[dto.restrictionId],
					title: $0[dto.title],
					location: $0[dto.location],
					openDate: $0[dto.openDate],
					closeDate: $0[dto.closeDate]
				)
			}
			completion(fetchedTournaments)
		} catch {
			NSLog(error.localizedDescription)
			completion([])
		}
	}
}

