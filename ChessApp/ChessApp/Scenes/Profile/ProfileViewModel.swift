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
	@Published var isEditingPhoto: Bool = false
	@Published var isLoading: Bool = false
	private unowned let rootCoordinator: RootCoordinator
	private let storage: AccountStoring

	init(rootCoordinator: RootCoordinator) {
		self.rootCoordinator = rootCoordinator
		// MARK: DI - will be replaced with Dependency Injection Container
		storage = AccountStorage()
	}

	func saveUserState() {
		isLoading = true
		storage.store(account: userState) { isSucceeded in
			self.isLoading = false
			if isSucceeded {
				// do nothing
			} else {
				// TODO: show alert
			}
		}
	}

	func restoreUserState() {
		isLoading = true
		storage.restore { userState in
			self.isLoading = false
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
		//
	}
}

struct User: Identifiable, Codable {
	let id: String
	var name: String?
	var surname: String?
	var fideRatings: Ratings?
	var russianRatings: Ratings?
	var fideID: Int?
	var russianID: Int?
	var imageData: Data?
	var role: ChessRole = .player
}

extension User {
	static let `default` = User(id: UUID().uuidString)
}

struct Ratings: Codable {
	let classic: Int?
	let rapid: Int?
	let blitz: Int?
}



enum ChessRole: String, CaseIterable, Identifiable, Codable {
//	var description: String {
//		switch self {
//		case .admin: return "Игрок"
//		case .player: return "Организатор"
//		}
//	}

	case player = "Игрок"
	case admin = "Организатор"

	var id: String { rawValue }
}
