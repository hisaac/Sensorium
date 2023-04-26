import SwiftUI

@main
struct SensoriumApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate

	var body: some Scene {
		Settings {
			SettingsView()
		}
	}
}

class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ notification: Notification) {
		openSettingsWindow()
	}

	func openSettingsWindow() {
		// Works around an annoyance where the app always comes to the foreground when
		// being previewed in Xcode's SwiftUI Canvas.
		guard
			ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1"
		else {
			return
		}

		NSApplication.shared.showSettingsWindow()
	}
}

extension NSApplication {
	func showSettingsWindow() {
		// source: https://stackoverflow.com/a/75712446/4118208
		if #available(macOS 13, *) {
			NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
		} else {
			NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
		}
	}
}
