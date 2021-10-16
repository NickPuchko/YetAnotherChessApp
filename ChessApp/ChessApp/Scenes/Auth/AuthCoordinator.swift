//
//  AuthCoordinator.swift
//  ChessApp
//
//  Created by maksim.surkov on 25.09.2021.
//

import Foundation
import Combine

final class AuthCoordinator: ObservableObject {
    @Published var authViewModel: AuthorizationViewModel!
    @Published var resetPasswordViewModel: DetailedEventViewModel?
    @Published var registrationViewModel: DetailedEventViewModel?

    private unowned let rootCoordinator: RootCoordinator

    init(rootCoordinator: RootCoordinator) {
        self.rootCoordinator = rootCoordinator
        authViewModel = .init(self)
    }

    func openDetailed(event: EventState) {
        detailedEventViewModel = DetailedEventViewModel(
            eventState: event,
            searchCoordinator: self
        )
    }
    func openResetPassword() {
        
    }
    func openRegistration() {
        
    }
}
