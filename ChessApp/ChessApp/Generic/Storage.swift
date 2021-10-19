//
//  Storage.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 11.10.2021.
//

import Foundation
import SQLite


public protocol Storage {
	var db: Connection { get }
	func copyDatabaseIfNeeded(sourcePath: String) -> Bool
}

public extension Storage {
	func copyDatabaseIfNeeded(sourcePath: String) -> Bool {
		let destinationPath = LocalConstants.sqlPath
		let exists = FileManager.default.fileExists(atPath: destinationPath)
		guard !exists else { return false }
		do {
			try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath)
			Logger.shared.info("Database copied")
			return true
		} catch let error {
			Logger.shared.error("Error during file copy", error: error)
			return false
		}
	}
}
