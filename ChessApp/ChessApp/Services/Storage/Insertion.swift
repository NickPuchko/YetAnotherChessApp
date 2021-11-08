//
//  Insertion.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 19.10.2021.
//

import Foundation
import SQLite

extension Store {
	func insert(_ tournament: Tournament, completion: @escaping (Int64?) -> Void) {
		let tournaments = Table(.tournaments)
		let dto = Tournament.DTO()
		let query = tournaments.insert(
			or: .replace,
			dto.title <- tournament.title,
			dto.location <- tournament.location,
			dto.restrictionId <- tournament.restrictionId,
			dto.openDate <- tournament.openDate,
			dto.closeDate <- tournament.closeDate
		)
		do {
			let rowid = try db?.run(query)
			completion(rowid)
			NSLog("Inserted tournament with id: \(String(describing: rowid))")
		} catch {
			completion(nil)
			NSLog(error.localizedDescription)
		}
	}

	func insert(_ restriction: Restriction, completion: @escaping (Int64?) -> Void) {
		let restrictions = Table(.restrictions)
		let dto = Restriction.DTO()
		let query = restrictions.insert(
			or: .replace,
			dto.minRating <- restriction.minRating,
			dto.maxRating <- restriction.maxRating,
			dto.minAge <- restriction.minAge,
			dto.maxAge <- restriction.maxAge,
			dto.gender <- restriction.gender?.rawValue,
			dto.deadlineDate <- restriction.deadlineDate
		)
		do {
			let rowid = try db?.run(query)
			completion(rowid)
			NSLog("Inserted restriction with id: \(String(describing: rowid))")
		} catch let Result.error(message, code, statement) {
			completion(nil)
			NSLog(message)
			NSLog(String(describing: code))
			NSLog(String(describing: statement))
		} catch {
			completion(nil)
			NSLog(error.localizedDescription)
		}
	}
}


