import Cocoa
import Combine

final class ApplicationActivationSensor: Sensor {
	let name = "Application Activation"
	let description = "Senses for the activation or deactivation of the specified application"
	var enabled = false

	var subscriptions = Set<AnyCancellable>()
	let monitoredApplicationBundleID: String

	init(
		monitoredApplicationBundleID: String,
		monitorActivation: Bool,
		monitorDeactivation: Bool
	) {
		self.monitoredApplicationBundleID = monitoredApplicationBundleID

		if monitorActivation {
			NSWorkspace.shared.notificationCenter
				.publisher(for: .didActivateApplication)
				.sink { self.handleActivation($0) }
				.store(in: &subscriptions)
		}

		if monitorDeactivation {
			NSWorkspace.shared.notificationCenter
				.publisher(for: .didDeactivateApplication)
				.sink { self.handleDeactivation($0) }
				.store(in: &subscriptions)
		}
	}

	private func handleActivation(_ notification: Notification) {
		guard
			let userInfo = notification.userInfo,
			let applicationKey = userInfo["NSWorkspaceApplicationKey"] as? NSRunningApplication,
			let bundleID = applicationKey.bundleIdentifier,
			monitoredApplicationBundleID == bundleID
		else {
			return
		}

		logNotification(notification)
	}

	private func handleDeactivation(_ notification: Notification) {
		guard
			let userInfo = notification.userInfo,
			let applicationKey = userInfo["NSWorkspaceApplicationKey"] as? NSRunningApplication,
			let bundleID = applicationKey.bundleIdentifier,
			monitoredApplicationBundleID == bundleID
		else {
			return
		}

		logNotification(notification)
	}

	deinit {
		subscriptions.forEach { $0.cancel() }
	}
}
