//
//  DetailedEventView.swift
//  DetailedEventView
//
//  Created by Nikolai Puchko on 12.09.2021.
//

import SwiftUI

struct DetailedEventView: View {
	@ObservedObject var vm: DetailedEventViewModel

    var body: some View {
		Text(vm.eventState.title)
    }
}
