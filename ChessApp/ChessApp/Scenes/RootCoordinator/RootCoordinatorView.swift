//
//  RootCoordinatorView.swift
//  RootCoordinatorView
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import SwiftUI

struct RootCoordinatorView: View {
	typealias Tab = RootCoordinator.RootTab
	@ObservedObject var coordinator: RootCoordinator

    var body: some View {
		TabView(selection: $coordinator.tab) {
			Text("Турниры")
				.tabItem {
					Text(Tab.events.rawValue)
					Image(systemName: "crown")
				}
				.tag(RootCoordinator.RootTab.events)
			SearchCoordinatorView(coordinator: coordinator.searchCoordinator)
				.tabItem {
					Text(Tab.search.rawValue)
					Image(systemName: "magnifyingglass")
				}
				.tag(RootCoordinator.RootTab.search)
			Text("Профиль")
				.tabItem {
					Text(Tab.profile.rawValue)
					Image(systemName: "person")
				}
				.tag(Tab.profile)
		}
    }
}

//struct RootCoordinatorView_Previews: PreviewProvider {
//    static var previews: some View {
//		RootCoordinatorView(coordinator: RootCoordinator())
//    }
//}
