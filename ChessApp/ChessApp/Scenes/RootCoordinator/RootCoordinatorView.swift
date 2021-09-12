//
//  RootCoordinatorView.swift
//  RootCoordinatorView
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import SwiftUI

struct RootCoordinatorView: View {
	@ObservedObject var coordinator: RootCoordinator

    var body: some View {
		TabView(selection: $coordinator.tab) {
			Text("Турниры")
				.tabItem {
					Text(SelectedTab.events.rawValue)
					Image(systemName: "crown")
				}
				.tag(RootCoordinator.RootTab.events)
			SearchCoordinatorView(coordinator: coordinator.searchCoordinator)
				.tabItem {
					Text(SelectedTab.search.rawValue)
					Image(systemName: "magnifyingglass")
				}
				.tag(RootCoordinator.RootTab.search)
			Text("Профиль")
				.tabItem {
					Text(SelectedTab.profile.rawValue)
					Image(systemName: "person")
				}
				.tag(RootCoordinator.RootTab.profile)
		}
    }
}

//struct RootCoordinatorView_Previews: PreviewProvider {
//    static var previews: some View {
//		RootCoordinatorView(coordinator: RootCoordinator())
//    }
//}
