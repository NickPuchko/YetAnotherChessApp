//
//  RootCoordinatorView.swift
//  RootCoordinatorView
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import SwiftUI
import Introspect

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
        .introspectTabBarController { tabBarController in
            _ = coordinator.$isTabBarHidden.sink { isHidden in
                let frame = tabBarController.tabBar.frame
                let factor: CGFloat = isHidden ? 1 : -1
                let y = frame.origin.y + (frame.size.height * factor)
                let newFrame = CGRect(
                    x: frame.origin.x,
                    y: y,
                    width: frame.width,
                    height: frame.height
                )
                UIView.animate(withDuration: 0.3, animations: {
                    tabBarController.tabBar.frame = newFrame
                })
            }
        }
    }
}
