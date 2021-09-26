//
//  ProfileRowView.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 26.09.2021.
//

import SwiftUI

extension ProfileView {
	enum RowRatingType {
		case fide
		case russian

		var description: String {
			switch self {
			case .fide: return "FIDE"
			case .russian: return "ФШР"
			}
		}

		var imageName: String {
			switch self {
			case .fide: return "fide"
			case .russian: return "frc"
			}
		}
	}
}

struct ProfileRowView: View {
	let ratingType: ProfileView.RowRatingType
	@State var isExpanded: Bool = false
	@State var title: String
	@Binding var ratings: Ratings?
	@Binding var id: Int?

	private var profileURL: URL {
		switch (id, ratingType) {
		case (let .some(profile), .fide): return .fide.appendingPathComponent("/profile/\(profile.description)")
		case (let .some(person), .russian): return .frc.appendingPathComponent("/people/\(person.description)")
		case (.none, .fide): return .fide
		case (.none, .russian): return .frc
		}
	}

	private let imageWidth = 30.0
	private let margin = 20.0
	private var inset: Double { imageWidth + 2 * margin }

	var body: some View {
		VStack(spacing: 8) {
			HStack(spacing: 0) {
				Image(ratingType.imageName)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: imageWidth, height: imageWidth)
					.padding([.leading, .trailing], margin)
				Text(title)
				Spacer()
				Button(action: {
					withAnimation {
						isExpanded.toggle()
					}
				}) {
					Image(systemName: .chevronDown)
						.rotationEffect(Angle.degrees(isExpanded ? 0 : 180))
						.padding(.trailing, margin)
				}
			}
			if isExpanded {
				RatingView(inset: inset, title: "Классика", rating: ratings?.classic)
					.padding(.top)
				RatingView(inset: inset, title: "Рапид", rating: ratings?.rapid)
				RatingView(inset: inset, title: "Блиц", rating: ratings?.blitz)
					.padding(.bottom)
				Link("Открыть профиль \(ratingType.description)", destination: profileURL)
			}
		}
		.frame(maxWidth: .infinity)
		.padding([.top, .bottom])
		.background(.systemGray6)
		.cornerRadius(16)
		.padding([.leading, .trailing])
	}
}

private struct RatingView: View {
	let inset: Double
	let title: String
	let rating: Int?

	var body: some View {
		HStack(spacing: 0) {
			Text(title)
				.fontWeight(.thin)
				.padding(.leading, inset)
			Spacer(minLength: 8)
			Text(rating?.description ?? "-")
				.fontWeight(.thin)
				.padding(.trailing, inset)
		}
	}
}

struct ProfileRowView_Previews: PreviewProvider {
    static var previews: some View {
			ProfileRowView(
				ratingType: .fide,
				isExpanded: false,
				title: "FIDE",
				ratings: .constant(Ratings(classic: 2054, rapid: 2046, blitz: 1960)),
				id: .constant(1503014)
			)
    }
}
