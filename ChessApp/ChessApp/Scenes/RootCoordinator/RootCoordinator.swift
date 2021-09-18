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
    @Published var isTabBarHidden: Bool

	init(tab: RootTab) {
		self.tab = tab
        isTabBarHidden = false
		searchCoordinator = .init(rootCoordinator: self)
	}
}
