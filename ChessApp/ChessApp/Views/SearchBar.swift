//
//  SearchBar.swift
//  SearchBar
//
//  Created by Nikolai Puchko on 11.09.2021.
//

import SwiftUI

struct SearchBar: View {
	@Binding var text: String
	@Binding var isSearching: Bool
	@State private var isEditing = false {
		didSet(newValue) {
			if !newValue {
				UIApplication.shared.windows.forEach { $0.endEditing(true) }
			}
		}
	}

	var body: some View {
		HStack {
			TextField("Начинайте печатать", text: $text)
				.disableAutocorrection(true)
				.padding(7)
				.padding(.horizontal, 25)
				.background(Color(.systemGray6))
				.cornerRadius(8)
				.overlay(
					HStack {
						Image(systemName: "magnifyingglass")
							.foregroundColor(.gray)
							.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
							.padding(.leading, 8)
					}
				)
				.padding(.horizontal, 10)
				.onTapGesture {
					isEditing = true
				}
			if isEditing {
				Button(action: {
					withAnimation {
						isSearching = false
						isEditing = false
						text = ""
					}
				}) {
					Text("Отменить")
				}
				.padding(.trailing, 10)
				.transition(.move(edge: .trailing))
			}
		}
		.animation(.default)
	}
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
		SearchBar(text: .constant(""), isSearching: .constant(true))
    }
}
