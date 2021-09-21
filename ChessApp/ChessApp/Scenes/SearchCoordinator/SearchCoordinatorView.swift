//
//  SearchCoordinatorView.swift
//  SearchCoordinatorView
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import SwiftUI

struct SearchCoordinatorView: View {
	@ObservedObject var coordinator: SearchCoordinator
    var body: some View {
		NavigationView {
			SearchView(vm: coordinator.searchViewModel)
				.navigation(item: $coordinator.detailedEventViewModel) { vm in
					DetailedEventView(vm: vm)
				}
		}
    }
}
