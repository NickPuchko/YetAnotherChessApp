//
//  RootCoordinator.swift
//  RootCoordinator
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import Combine

final class RootCoordinator: ObservableObject {
	enum RootTab: String {
		case events = "Турниры"
		case search = "Поиск"
		case profile = "Профиль"
	}

	@Published var searchCoordinator: SearchCoordinator!
	@Published var tab: RootTab
	@Published var isTabBarHidden: Bool = false
	@Published var isLoading: Bool = false

	init(tab: RootTab) {
		self.tab = tab
		searchCoordinator = .init(rootCoordinator: self)
	}
}
