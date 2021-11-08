//
//  AccountStorage.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 18.09.2021.
//

import Foundation
import SQLite

final class Store {
	public enum QueryError: Error {
		case failedToCreateUsers
		case failedToCreatePlayers
		case failedToCreateRatings
		case failedToCreateAppUsers
		case failedToCreateOrganizers
		case failedToCreateCompanies
		case failedToCreateParticipations
		case failedToCreateTournaments
		case failedToCreateRestrictions
		case failedToCreateTours
		case failedToCreateGames
	}

	let db = try? Connection(LocalConstants.sqlPath)
	var isDatabaseReady: Bool = false

	func createTables(completion: @escaping (QueryError?) -> Void) {
		db?.trace {
			NSLog($0)
		}
		// MARK: - Common
		let id = Expression<Int64>("id")

		// MARK: - Application Users
		let appUsers = Table("app_users")
		let organizerId = Expression<Int64?>("organizer_id")
		let email = Expression<String>("email")

		// MARK: - Organizers
		let organizers = Table("organizers")
		let companyId = Expression<Int64>("company_id")

		// MARK: - Companies
		let companies = Table("companies")
		let label = Expression<String>("label")
		let url = Expression<String?>("url")


		// MARK: - Users
		let users = Table("users")
		let name = Expression<String>("name")
		let surname = Expression<String>("surname")
		let latinName = Expression<String?>("latin_name")
		let playerId = Expression<Int64>("player_id")

		// MARK: - Players
		let players = Table("players")
		let userId = Expression<Int64?>("user_id")
		let fideId = Expression<Int64?>("fide_id")
		let russianId = Expression<Int64?>("russian_id")

		// MARK: - Ratings
		let fideRatings = Table("fide_ratings")
		let russianRatings = Table("russian_ratings")
		let classic = Expression<Int64?>("classic")
		let rapid = Expression<Int64?>("rapid")
		let blitz = Expression<Int64?>("blitz")
		let bullet = Expression<Int64?>("bullet")

		// MARK: - Participations
		let participations = Table("participations")
		let participantId = Expression<Int64>("participant_id")
		let tournamentId = Expression<Int64>("tournament_id")
		let status = Expression<String>("status")
		let date = Expression<Date>("date")

		// MARK: - Tournaments
		let tournaments = Table("tournaments")
		let restrictionId = Expression<Int64>("restriction_id")
		let title = Expression<String>("title")
		let location = Expression<String?>("location")
		let openDate = Expression<Date>("open_date")
		let closeDate = Expression<Date?>("close_date")

		// MARK: - Restrictions
		let restrictions = Table("restrictions")
		let minRating = Expression<Int64?>("min_rating")
		let maxRating = Expression<Int64?>("max_rating")
		let minAge = Expression<Int64?>("min_age")
		let maxAge = Expression<Int64?>("max_age")
		let gender = Expression<String?>("gender")
		let deadlineDate = Expression<Date>("deadline_date")

		// MARK: - Tours
		let tours = Table("tours")
		let number = Expression<Int64>("number")
		let dateStart = Expression<Date?>("date_start")

		// MARK: - Games
		let games = Table("games")
		let tourId = Expression<Int64>("tour_id")
		let whitePlayerId = Expression<Int64>("white_player_id")
		let blackPlayerId = Expression<Int64>("black_player_id")
		let result = Expression<Double?>("result")
		let duration = Expression<Int64?>("duration")
		let moves = Expression<Int64?>("moves")

		let createUsers = users.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(name)
			builder.column(surname)
			builder.column(latinName)
			builder.column(playerId, references: players, playerId)
		}

		let createPlayers = players.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(userId, references: users, id)
			builder.column(fideId, references: fideRatings, id)
			builder.column(russianId, references: russianRatings, id)
		}

		var createRatings = [fideRatings, russianRatings].map {
			$0.create(ifNotExists: true) { builder in
				builder.column(id, primaryKey: .autoincrement)
				builder.column(classic)
				builder.column(rapid)
				builder.column(blitz)
				builder.column(bullet)
			}
		}

		let createAppUsers = appUsers.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(organizerId, references: organizers, id)
			builder.column(email, unique: true)
		}

		let createOrganizers = organizers.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(companyId, references: companies, id)
		}

		let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
		let createCompanies = organizers.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(label, unique: true)
			builder.column(url, check: url.like(regEx))
		}

		let createParticipations = participations.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(participantId, references: players, id)
			builder.column(tournamentId, references: tournaments, id)
			builder.column(status, check: Status.allCases.map{ $0.rawValue }.contains(status))
			builder.column(date, check: openDate <= Date(), defaultValue: Date())
		}

		let createTournaments = tournaments.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(restrictionId, references: restrictions, id)
			builder.column(title)
			builder.column(location)
			builder.column(openDate, check: openDate <= Date(), defaultValue: Date())
			builder.column(closeDate, check: closeDate >= Date())
		}

		let createRestrictions = restrictions.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(minRating, check: minRating >= 0, defaultValue: 0)
			builder.column(maxRating, check: maxRating >= 0, defaultValue: 3000)
			builder.column(minAge, check: minAge >= 0, defaultValue: 0)
			builder.column(maxAge, check: maxAge >= 0, defaultValue: 200)
			builder.column(gender, check: Gender.allCases.map{ $0.rawValue }.contains(gender))
			builder.column(deadlineDate, defaultValue: Date.distantFuture)
		}

		let createTours = tours.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(tournamentId, references: tournaments, id)
			builder.column(number, check: number > 0)
			builder.column(dateStart, check: dateStart > Date())
		}

		let createGames = games.create(ifNotExists: true) { builder in
			builder.column(id, primaryKey: .autoincrement)
			builder.column(tourId, references: tours, id)
			builder.column(whitePlayerId, references: players, id)
			builder.column(blackPlayerId, references: players, id)
			builder.column(result, check: [-1, 0, 0.5, 1].contains(result))
			builder.column(duration, check: duration >= 0)
			builder.column(moves, check: moves >= 0)
		}

		do {
			try db?.run(createUsers)
		} catch {
			completion(.failedToCreateUsers)
		}

		do {
			try db?.run(createPlayers)
		} catch {
			completion(.failedToCreatePlayers)
		}

		do {
			try db?.run(createRatings.removeFirst())
			try db?.run(createRatings.removeFirst())
		} catch {
			completion(.failedToCreateRatings)
		}

		do {
			try db?.run(createAppUsers)
		} catch {
			completion(.failedToCreateAppUsers)
		}

		do {
			try db?.run(createOrganizers)
		} catch {
			completion(.failedToCreateOrganizers)
		}

		do {
			try db?.run(createCompanies)
		} catch {
			completion(.failedToCreateCompanies)
		}

		do {
			try db?.run(createParticipations)
		} catch {
			completion(.failedToCreateParticipations)
		}

		do {
			try db?.run(createTournaments)
		} catch {
			completion(.failedToCreateTournaments)
		}

		do {
			try db?.run(createRestrictions)
		} catch {
			completion(.failedToCreateRestrictions)
		}

		do {
			try db?.run(createTours)
		} catch {
			completion(.failedToCreateTours)
		}

		do {
			try db?.run(createGames)
		} catch {
			completion(.failedToCreateGames)
		}

		DispatchQueue.global().async {
			_ = try? self.db?.vacuum()
			completion(nil)
			self.isDatabaseReady = true
		}
	}

	func clearTable(of type: TableType?) {
		isDatabaseReady = false
		if let type = type {
			let table = Table(type.rawValue)
			let query = table.delete()
			_ = try? db?.run(query)
			_ = try? self.db?.vacuum()
		} else {
			TableType.allCases.forEach {
				let query = Table($0.rawValue).delete()
				_  = try? db?.run(query)
			}
		}
	}
}


extension Table {
	init(_ type: TableType) {
		self.init(type.rawValue)
	}
}
