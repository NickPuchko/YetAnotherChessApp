//
//  ProfileFormView.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 26.09.2021.
//

import SwiftUI

struct ProfileFormView: View {
	@ObservedObject var vm: ProfileViewModel
	var body: some View {
		VStack {
			Form {
				Section {
					Picker("Роль", selection: $vm.userState.role) {
						ForEach(ChessRole.allCases) { role in
							Text(role.rawValue)
								.tag(role)
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				TextField("Фамилия", text: $vm.userState.surname)
				TextField("Имя", text: $vm.userState.name)
				TextField("FIDE ID", value: $vm.userState.fideID, formatter: NumberFormatter())
					.keyboardType(.numberPad)
				TextField("ФШР ID", value: $vm.userState.russianID, formatter: NumberFormatter())
					.keyboardType(.numberPad)
				Button("Сохранить") {
					vm.isEditing = false
					vm.saveUserState()
				}
			}
		}
		.ignoresSafeArea()
	}
}
