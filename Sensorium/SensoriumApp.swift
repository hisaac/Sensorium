import SwiftUI

@main
struct SensoriumApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}

class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ notification: Notification) {

	}
}
