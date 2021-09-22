//
//  ProfileViewModel.swift
//  ProfileViewModel
//
//  Created by Nikolai Puchko on 18.09.2021.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
	@Published var userState: User = .default
	@Published var isAuthorized: Bool = false
	@Published var isEditing: Bool = false
	private unowned let rootCoordinator: RootCoordinator
	private let storage: AccountStoring

	init(rootCoordinator: RootCoordinator) {
		self.rootCoordinator = rootCoordinator
//		userState = .default
		// MARK: DI - will be replaced with Dependency Injection Container
		storage = AccountStorage()
	}

	func saveUserState() {
//		userState = .init(id: UUID().uuidString, name: "John", surname: "Doe", role: .admin, ratings: nil, fideID: 1488, russianID: 1488, imageData: nil)
		rootCoordinator.isLoading = true
		storage.store(account: userState) { isSucceeded in
			self.rootCoordinator.isLoading = false
			if isSucceeded {
				// do nothing
			} else {
				// TODO: show alert
			}
		}
	}

	func restoreUserState() {
		rootCoordinator.isLoading = true
		storage.restore { userState in
			self.rootCoordinator.isLoading = false
			guard let userState = userState else {
				// TODO: show login button
				self.isAuthorized = false
				return
			}
			self.isAuthorized = true
			self.userState = userState
		}
	}

	func signOut() {
		storage.clear()
	}
}

struct User: Identifiable, Codable {
	let id: String
	var name: String?
	var surname: String?
	var role: ChessRole?
	var ratings: Ratings?
	var fideID: Int?
	var russianID: Int?
	var imageData: Data?

	var twoLineFullname: String {
		guard let name = name,
			  let surname = surname else {
			return ""
		}
		return name + "\n" + surname
	}
}

extension User {
	static let `default` = User(id: UUID().uuidString)
}

struct Ratings: Codable {
	let fideClassic: Int?
	let fideRapid: Int?
	let fideBlitz: Int?
	let russianClassic: Int?
	let russianRapid: Int?
	let russianBlitz: Int?
}

enum ChessRole: CustomStringConvertible, CaseIterable, Codable {
	var description: String {
		switch self {
		case .admin: return "Игрок"
		case .player: return "Организатор"
		}
	}

	case player
	case admin
}
