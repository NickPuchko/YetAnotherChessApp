//
//  Backup.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 19.10.2021.
//

import Foundation
import SQLite

// MARK: - Bloody 15-days trial is over
//import SQLCipher

extension Store {
	func backup(to path: String?) {
		assertionFailure("SQLCipher is not supported at the moment")
//		do {
//			let target = try Connection(.inMemory)
//			let backup = try db?.backup(usingConnection: target)
//			try backup.step()
//		} catch {
//			NSLog(error.localizedDescription)
//		}
	}
}


