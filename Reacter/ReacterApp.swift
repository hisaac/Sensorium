import SwiftUI

@main
struct ReacterApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}

class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ notification: Notification) {
		let applicationActivationSensor = ApplicationActivationSensor(
			monitoredApplicationBundleID: "tv.plex.plexamp",
			monitorActivation: true,
			monitorDeactivation: true
		)
	}
}
