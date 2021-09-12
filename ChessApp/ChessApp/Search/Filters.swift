//
//  Filters.swift
//  Filters
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import SwiftUI

struct Filters: View {
	@Binding var startDate: Date
	@Binding var endDate: Date

	// TODO: consider other pickers
	// @Binding var ratingType: RatingType
	// @Binding var mode: GameMode

    var body: some View {
		ScrollView {
			HStack {
				DatePicker("Начало", selection: $startDate, in: Date()...)
					.datePickerStyle(CompactDatePickerStyle())
				DatePicker("Конец", selection: $endDate, in: Date()...)
					.datePickerStyle(CompactDatePickerStyle())
				Spacer()
			}
		}
    }
}

struct Filters_Previews: PreviewProvider {
    static var previews: some View {
		Filters(
			startDate: .constant(Date()),
			endDate: .constant(Date(timeIntervalSinceNow: 300_000))
//			ratingType: .constant(.fide),
//			mode: .constant(.fide)
		)
    }
}
