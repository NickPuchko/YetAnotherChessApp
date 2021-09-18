//
//  SearchCoordinator.swift
//  SearchCoordinator
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import Combine

final class SearchCoordinator: ObservableObject {
	@Published var searchViewModel: SearchViewModel!
	@Published var detailedEventViewModel: DetailedEventViewModel?

	private unowned let rootCoordinator: RootCoordinator

	init(rootCoordinator: RootCoordinator) {
		self.rootCoordinator = rootCoordinator
		searchViewModel = .init(searchCoordinator: self)
	}

	func openDetailed(event: EventState) {
		detailedEventViewModel = DetailedEventViewModel(
			eventState: event,
			searchCoordinator: self
		)
	}

    func showTabBar(_ hidden: Bool) {
        rootCoordinator.isTabBarHidden = hidden
    }
}

