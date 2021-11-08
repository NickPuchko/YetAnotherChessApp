//
//  SearchCoordinatorView.swift
//  SearchCoordinatorView
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import SwiftUI
import Introspect

// TODO: something goes wrong here during layouting O_o
struct SearchCoordinatorView: View {
	@ObservedObject var coordinator: SearchCoordinator
	var body: some View {
		NavigationView {
			SearchView(vm: coordinator.searchViewModel)
				.navigation(item: $coordinator.detailedEventViewModel) { vm in
					DetailedEventView(vm: vm) .onAppear {
						coordinator.showTabBar(true)
					}
				}
		}.introspectNavigationController { navigationController in
			navigationController.navigationBar.standardAppearance = .withoutSeparator
			navigationController.navigationBar.scrollEdgeAppearance = .withoutSeparator
		}
	}
}
