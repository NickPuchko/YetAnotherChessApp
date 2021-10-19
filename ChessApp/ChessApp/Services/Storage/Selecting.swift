//
//  Selecting.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 19.10.2021.
//

import Foundation
import SQLite

extension Store {
	func selectTournaments(
		openDate: Date?,
		endDate: Date?,
		completion: @escaping ([Tournament]) -> Void
	) {
		var tournaments = Table(.tournaments).limit(30)
		let dto = Tournament.DTO()
		switch (openDate, endDate) {
		case (nil, nil):
			break
		case (let .some(date), nil):
			tournaments = tournaments
				.filter(dto.openDate >= date)
		case (nil, let .some(date)):
			tournaments = tournaments
				.filter(dto.closeDate <= date)
		case (let .some(dateStart), let .some(dateFinish)):
			tournaments = tournaments
				.filter(dto.openDate >= dateStart)
				.filter(dto.closeDate <= dateFinish)
		}
		do {
			let mapRowIterator = try db?.prepareRowIterator(tournaments)
			let results = try mapRowIterator?.map {
				Tournament(
					id: $0[dto.id],
					restrictionId: $0[dto.restrictionId],
					title: $0[dto.title],
					location: $0[dto.location],
					openDate: $0[dto.openDate],
					closeDate: $0[dto.closeDate]
				)
			}
			completion(results ?? [])
		} catch {
			NSLog(error.localizedDescription)
			completion([])
		}
	}
}
