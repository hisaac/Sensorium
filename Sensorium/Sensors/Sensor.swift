import Foundation

protocol Sensor {
	var name: String { get }
	var description: String { get }
	var enabled: Bool { get set }
}

extension Sensor {
	public func logNotification(_ notification: Notification? = nil) {
		guard let notification else { return }
		print(notification)
	}

	public func logMessage(_ message: String? = nil) {
		guard let message else { return }
		print(message)
	}
}
