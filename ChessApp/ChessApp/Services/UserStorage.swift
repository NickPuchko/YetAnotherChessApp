//
//  UserStorage.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 19.10.2021.
//

import Foundation

protocol AccountStoring {
	func store(account: User, completion: @escaping (Bool) -> Void)
	func restore(completion: @escaping (User?) -> Void)
}

/// Storage must be rafactored using SQLite.swift
final class AccountStorage: AccountStoring {
	private let fileManager: FileManager = .default
	private lazy var url: URL = {
		fileManager
			.urls(for: .documentDirectory, in: .userDomainMask)
			.first!
			.appendingPathComponent("account.json")
	}()

	func store(account: User, completion: @escaping (Bool) -> ()) {
		DispatchQueue.global(qos: .utility).async { [self] in
			do {
				let data = try JSONEncoder().encode(account)
				try data.write(to: url, options: [.atomic])
				NSLog("User with \(account.id) stored at \(url.description)")
				onMainThread {
					completion(true)
				}
			} catch let error {
				NSLog(error.localizedDescription)
				onMainThread {
					completion(false)
				}
			}
		}
	}

	func restore(completion: @escaping (User?) -> ()) {
		DispatchQueue.global(qos: .userInitiated).async { [self] in
			if !fileManager.fileExists(atPath: url.path) {
				let defaultAccount = User.default
				let data = try? JSONEncoder().encode(defaultAccount)
				try? data?.write(to: url)
			}
			do {
				let data = try Data(contentsOf: url)
				let account = try JSONDecoder().decode(User.self, from: data)
				NSLog("User with \(account.id) restored from \(url.description)")
				onMainThread {
					completion(account)
				}
			} catch let error {
				NSLog(error.localizedDescription)
				onMainThread {
					completion(nil)
				}
			}
		}
	}

	func clear() {
		DispatchQueue.global(qos: .utility).async { [self] in
			do {
				try fileManager.removeItem(at: url)
				NSLog("Cleared \(url.description)")
			} catch let error {
				NSLog(error.localizedDescription)
			}
		}
	}
}
