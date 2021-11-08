//
//  LocalConstants.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 01.10.2021.
//

import Foundation

enum LocalConstants {
	static let sqlPath = NSSearchPathForDirectoriesInDomains(
		.documentDirectory,
		.userDomainMask,
		true
	).first!.appending("/db.sqlite3")
}
