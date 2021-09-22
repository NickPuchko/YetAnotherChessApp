//
//  ProfileView.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 18.09.2021.
//

import SwiftUI
import SwiftUIX

struct ProfileView: View {
	@ObservedObject var vm: ProfileViewModel
	
	var body: some View {
		VStack(alignment: .center) {
			HStack {
				Spacer()
				Button(systemImage: .squareAndPencil) {
					vm.isEditing = true
				}
			}
			.padding()
			Image(data: (vm.userState.imageData ?? UIImage.symbol(.personCircle).pngData()!))?
				.resizable()
				.frame(width: 80, height: 80, alignment: .center)
			Text(vm.userState.twoLineFullname)
				.font(.title)
			Text((vm.userState.role ?? .player).description)
				.foregroundColor(.gray)
			Spacer()
		}
		.onAppear(perform: vm.restoreUserState)
		.sheet(isPresented: $vm.isEditing) {
			VStack {
				ImagePicker(data: $vm.userState.imageData, encoding: .png)
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
					}
				}
				Spacer()
			}
		}
	}
}

public extension UIImage {
	static func symbol(_ symbol: SFSymbolName) -> UIImage {
		UIImage(systemName: symbol.rawValue)
		?? UIImage(systemName: SFSymbolName.phone.rawValue)!
	}
}
