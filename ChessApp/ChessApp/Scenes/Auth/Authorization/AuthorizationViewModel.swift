//
//  AuthorizationViewModel.swift
//  ChessApp
//
//  Created by maksim.surkov on 25.09.2021.
//

import Foundation
import Combine


final class AuthorizationViewModel: ObservableObject {
    @Published var login: String
    @Published var password: String
    private unowned let searchCoordinator: SearchCoordinator

    init(login: String, password: String, searchCoordinator: SearchCoordinator) {
        self.login = login
        self.password = password
        self.searchCoordinator = searchCoordinator
    }
}
