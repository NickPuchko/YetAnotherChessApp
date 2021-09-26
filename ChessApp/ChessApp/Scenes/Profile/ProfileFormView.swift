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
				Picker("Роль", selection: $vm.userState.role) {
					ForEach(ChessRole.allCases, id: \.self) {
						Text($0.description)
					}
				}
				TextField("Фамилия", text: $vm.userState.surname)
				TextField("Имя", text: $vm.userState.name)
				TextField("FIDE ID", value: $vm.userState.fideID, formatter: NumberFormatter())
				TextField("ФШР ID", value: $vm.userState.russianID, formatter: NumberFormatter())
				Button("Сохранить") {
					vm.isEditing = false
					vm.saveUserState()
				}
			}
			Spacer()
		}
	}
}
