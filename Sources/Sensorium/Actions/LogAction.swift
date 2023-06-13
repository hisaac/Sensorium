import AppKit
import Combine
import os.log

final class LogAction: Action {
	let name = #file
	let friendlyName = "Log Action"
	let description = "Action for logging events"

	func perform(event: SensedEvent) {
		Logger.logAction.info("Sensorium event: \(event.debugDescription, privacy: .public)")
	}
}

extension Logger {
	private static var subsystem = Bundle.main.bundleIdentifier!

	static let logAction = Logger(subsystem: subsystem, category: "logAction")
}
