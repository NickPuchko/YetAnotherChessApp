//
//  RootCoordinator.swift
//  RootCoordinator
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import Combine

final class RootCoordinator: ObservableObject {
	enum RootTab {
		case events, search, profile
	}

	@Published var searchCoordinator: SearchCoordinator!
	@Published var tab: RootTab

	init(tab: RootTab) {
		self.tab = tab
		searchCoordinator = .init(rootCoordinator: self)
	}
}
