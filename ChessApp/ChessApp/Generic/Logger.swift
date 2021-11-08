//
//  Logger.swift
//  ChessApp
//
//  Created by Nikolai Puchko on 11.10.2021.
//

import CocoaLumberjack
import CocoaLumberjackSwift

public final class Logger {
	private(set) var ddLog = DDLog()
	public static var shared = Logger()

	private init() {
		ddLog.add(DDOSLogger.sharedInstance, with: .info)

		DDFileLogger().do {
			$0.rollingFrequency = 60 * 60 * 24 // 24 hours
			$0.logFileManager.maximumNumberOfLogFiles = 7 // week
			ddLog.add($0, with: .all)
		}
	}
}

public extension Logger {
	func debug(
		_ message: String,
		newlines: Bool = true,
		file: String = #file,
		line: UInt = #line,
		column: Int = #column,
		function: String = #function,
		params: [String: String] = [:]
	) {
		DDLogMessage(
			message: message,
			level: .debug,
			flag: .debug,
			context: context,
			file: file,
			function: function,
			line: line,
			tag: params,
			options: messageOptions,
			timestamp: nil
		).do {
			ddLog.log(asynchronous: true, message: $0)
		}
	}

	func info(
		_ message: String,
		newlines: Bool = true,
		file: String = #file,
		line: UInt = #line,
		column: Int = #column,
		function: String = #function,
		params: [String: String] = [:]
	) {
		DDLogMessage(
			message: message,
			level: .info,
			flag: .info,
			context: context,
			file: file,
			function: function,
			line: line,
			tag: params,
			options: messageOptions,
			timestamp: nil
		).do {
			ddLog.log(asynchronous: true, message: $0)
		}
	}

	func warning(
		_ message: String,
		newlines: Bool = true,
		file: String = #file,
		line: UInt = #line,
		column: Int = #column,
		function: String = #function,
		params: [String: String] = [:]
	) {
		DDLogMessage(
			message: message,
			level: .warning,
			flag: .warning,
			context: context,
			file: file,
			function: function,
			line: line,
			tag: params,
			options: messageOptions,
			timestamp: nil
		).do {
			ddLog.log(asynchronous: true, message: $0)
		}
	}

	func error(
		_ message: String,
		error: Error? = nil,
		newlines: Bool = true,
		file: String = #file,
		line: UInt = #line,
		column: Int = #column,
		function: String = #function,
		crash: Bool = true
	) {
		DDLogMessage(
			message: message,
			level: .error,
			flag: .error,
			context: context,
			file: file,
			function: function,
			line: line,
			tag: error?.dictionarized,
			options: messageOptions,
			timestamp: nil
		).do {
			ddLog.log(asynchronous: true, message: $0)
		}
	}
}

private let context: Int = 0
private let messageOptions: DDLogMessageOptions = [.copyFile, .copyFunction]
