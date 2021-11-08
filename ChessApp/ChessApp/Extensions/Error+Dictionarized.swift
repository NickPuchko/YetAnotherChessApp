//
//  Error+Dictionarized.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 11.10.2021.
//

public extension Error {
	var dictionarized: [String: String] {
		["localizedDescription": localizedDescription]
	}
}
