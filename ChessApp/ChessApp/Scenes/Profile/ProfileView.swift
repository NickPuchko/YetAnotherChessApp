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
		ZStack {
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
					.clipShape(Circle())
					.onTapGesture {
						vm.isEditingPhoto.toggle()
					}
					.overlay {
						HStack {
							Spacer()
							VStack {
								Spacer()
								Image(systemName: .pencilCircle).foregroundColor(.blue)
							}
						}
					}
				Text(vm.userState.name ?? "")
					.font(.title)
				Text(vm.userState.surname ?? "")
					.font(.title)
				Text((vm.userState.role ?? .player).description)
					.foregroundColor(.gray)
				ProfileRowView(
					ratingType: .fide,
					title: "FIDE",
					ratings: $vm.userState.fideRatings,
					id: $vm.userState.fideID
				)
				ProfileRowView(
					ratingType: .russian,
					title: "ФШР",
					ratings: $vm.userState.russianRatings,
					id: $vm.userState.russianID
				)
				Button(action: vm.signOut) {
					Text("Выйти")
						.fontWeight(.thin)
						.foregroundColor(.red)
						.padding()
				}
				Spacer()
			}
			.onAppear(perform: vm.restoreUserState)
			.sheet(isPresented: $vm.isEditing) {
				ProfileFormView(vm: vm)
			}
			.sheet(isPresented: $vm.isEditingPhoto, onDismiss: {
				vm.saveUserState()
			}) {
				ImagePicker(data: $vm.userState.imageData, encoding: .png) {
					vm.isEditingPhoto.toggle()
				}
			}
			if vm.isLoading {
				Blur(style: .prominent).ignoresSafeArea()
				ProgressView()
			}
		}
	}
}
