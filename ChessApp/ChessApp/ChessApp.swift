//
//  ChessApp.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 11.09.2021.
//

import SwiftUI

@main
struct ChessApp: App {
	@StateObject private var coordinator = RootCoordinator(tab: .search)
    var body: some Scene {
			WindowGroup {
				RootCoordinatorView(coordinator: coordinator)
					.environment(\.colorScheme, .light) // TODO: replace with a real light theme support
			}
    }
}
