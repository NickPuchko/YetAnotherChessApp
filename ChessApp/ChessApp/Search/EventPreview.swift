//
//  EventPreview.swift
//  EventPreview
//
//  Created by Nikolai Puchko on 11.09.2021.
//

import SwiftUI

struct EventPreview: View {
	@State var eventState: EventState
    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Image(uiImage: eventState.imageData ?? UIImage(systemName: "paperplane")!)
					.resizable()
					.frame(width: 40, height: 40, alignment: .center)
					.padding([.leading, .trailing], 4)
				Text(eventState.title)
					.font(.title)
					.lineLimit(2)
				Spacer()
			}
			VStack(alignment: .leading) {
				HStack {
					Config.dateImage
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
					Text(eventState.startDate...eventState.endDate)
				}
				HStack {
					Config.locationImage
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
					Text(eventState.location)
				}
				HStack {
					eventState.ratingType.image
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
					Text(eventState.ratingType.description)
				}
				HStack {
					Config.timeImage
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
					Text(eventState.mode.rawValue)
				}
			}
			.padding(.leading, 40)
		}
		.padding()
		.frame(maxWidth: .infinity)
		.background(
			RoundedRectangle(cornerRadius: 16)
				.fill(.white)
				.shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 5)
		)
		.padding()
    }
}

struct EventPreview_Previews: PreviewProvider {
    static var previews: some View {
        EventPreview(
			eventState: EventState(
				id: 0,
				title: "Aeroflot open",
				location: "Moscow",
				imageData: UIImage(systemName: "paperplane.circle"),
				startDate: Date(timeIntervalSinceNow: 100_000),
				endDate: Date(timeIntervalSinceNow: 200_000),
				ratingType: .fide,
				mode: .classic
			)
		)
    }
}

extension Image {
	init?(from data: Data) {
		guard let image = UIImage(data: data) else {
			return nil
		}
		self.init(uiImage: image)
	}
}


extension EventPreview {
	private struct Config {
		static let dateImage = Image(systemName: "calendar")
		static let locationImage = Image(systemName: "location")
		static let ratingImage = Image(systemName: "star")
		static let timeImage = Image(systemName: "clock")
	}
}
