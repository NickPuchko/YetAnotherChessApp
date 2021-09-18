//
//  SearchView.swift
//  SearchView
//
//  Created by Nikolai Puchko on 11.09.2021.
//

import SwiftUI
import Combine
import SwiftUIX

struct SearchView: View {
	@ObservedObject var vm: SearchViewModel

    var body: some View {
		VStack {
			if vm.isSearching {
				SearchBar(text: $vm.searchString, isSearching: $vm.isSearching)
					.padding()
				Filters(startDate: $vm.startDate, endDate: $vm.endDate)
                    .padding([.leading, .trailing])
			}
			ScrollView {
				LazyVStack(spacing: 0) {
					ForEach(vm.filteredEvents) { event in
						EventPreview(eventState: event)
							.onNavigation {
								vm.openDetailed(event: event)
							}
					}
				}
				.id(UUID())
				.navigationTitle("Лента")
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button {
							withAnimation {
								vm.isSearching = !vm.isSearching
							}
						} label: {
							Config.lupa.resizable()
						}
					}
					ToolbarItem(placement: .navigationBarLeading) {
						Button {
							//
						} label: {
							Config.pupa.resizable()
						}
					}
				}
			}
		}
	}
}

extension SearchView {
	struct Config {
		static let lupa = Image(systemName: "text.magnifyingglass")
		static let pupa = Image(systemName: "bookmark")
	}
}
