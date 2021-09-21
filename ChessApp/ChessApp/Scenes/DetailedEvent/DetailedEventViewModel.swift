//
//  DetailedEventViewModel.swift
//  DetailedEventViewModel
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import Combine

final class DetailedEventViewModel: ObservableObject {
	@Published var eventState: EventState
	private unowned let searchCoordinator: SearchCoordinator

	init(eventState: EventState, searchCoordinator: SearchCoordinator) {
		self.eventState = eventState
		self.searchCoordinator = searchCoordinator
	}
}
