//
//  RootTab.swift
//  RootTab
//
//  Created by Nikolai Puchko on 11.09.2021.
//

import SwiftUI
import Combine

struct RootTab: View {
	@StateObject var rootState: RootState
    var body: some View {
		TabView(selection: $rootState.selectedTab) {
			Text(rootState.selectedTab.rawValue)
				.tabItem {
					Text(SelectedTab.events.rawValue)
					Image(systemName: "crown")
				}
				.tag(0)
			Text(rootState.selectedTab.rawValue)
				.tabItem {
					Text(SelectedTab.search.rawValue)
					Image(systemName: "magnifyingglass")
				}
				.tag(1)
			Text(rootState.selectedTab.rawValue)
				.tabItem {
					Text(SelectedTab.profile.rawValue)
					Image(systemName: "person")
				}
				.tag(2)
		}
    }
}

struct RootTab_Previews: PreviewProvider {
    static var previews: some View {
        RootTab(rootState: RootState())
    }
}

final class RootState: ObservableObject {
	var selectedTab: SelectedTab = .search
}

enum SelectedTab: String {
	case events = "Турниры"
	case search = "Поиск"
	case profile = "Профиль"
}
