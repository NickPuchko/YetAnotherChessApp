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
							// TODO: favourites or something else
						} label: {
							Config.pupa.resizable()
						}
					}
				}
			}
		}
		.popover(isPresented: $vm.isFormPresented) {
			Form {
				Section {
					TextField("Название турнира", text: $vm.title)
					TextField("Местоположение", text: $vm.location)
					DatePicker("Дата открытия", selection: $vm.openDate)
					DatePicker("Дата закрытия", selection: $vm.closeDate)
				}
				Section {
					TextField("Минимальный рейтинг", value: $vm.minRating, formatter: NumberFormatter())
					TextField("Максимальный рейтинг", value: $vm.maxRating, formatter: NumberFormatter())
					DatePicker("Дата закрытия заявок", selection: $vm.deadlineDate)
						.datePickerStyle(GraphicalDatePickerStyle())
				}
				Button("Создать") {
					vm.createEvent { succeeded in
						vm.isFormPresented = false
					}
				}
				.disabled(!(vm.title != "" && vm.location != ""))
			}
		}
		.overlay {
			VStack {
				Spacer()
				HStack {
					Button(systemImage: .trashCircle) {
						vm.clearData()
					}
					.font(.system(size: 40))
					.frame(width: 40, height: 40, alignment: .center)
					Spacer()
					Button(systemImage: .plusCircle) {
						vm.isFormPresented.toggle()
					}
					.font(.system(size: 40))
					.frame(width: 40, height: 40, alignment: .center)
				}
			}
			.padding()
		}

	}
}

extension SearchView {
	struct Config {
		static let lupa = Image(systemName: "text.magnifyingglass")
		static let pupa = Image(systemName: "bookmark")
	}
}
