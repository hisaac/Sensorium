import Foundation
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
	private var window: NSWindow!
	private var windowController: NSWindowController!

	let eventRouter = EventRouter()

	func applicationDidFinishLaunching(_ notification: Notification) {
		window = NSWindow(
			contentRect: NSZeroRect,
			styleMask: [.closable, .titled],
			backing: .buffered,
			defer: true
		)

		window.title = Bundle.main.infoDictionary?["CFBundleName"] as! String

		window.contentView = NSHostingView(rootView: SettingsView())
		windowController = NSWindowController(window: window)

		openSettingsWindow()
	}

	private var launchedAsLogInItem: Bool {
		// source: https://hisaac.net/how-to-detect-if-your-macos-app-was-launched-as-a-login-item/
		guard let event = NSAppleEventManager.shared().currentAppleEvent else { return false }
		return
			event.eventID == kAEOpenApplication &&
			event.paramDescriptor(forKeyword: keyAEPropData)?.enumCodeValue == keyAELaunchedAsLogInItem
	}

	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
		openSettingsWindow()
		return true
	}

	func openSettingsWindow() {
		// Works around an annoyance where the app always comes to the foreground when
		// being previewed in Xcode's SwiftUI Canvas.
		guard
			ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1"
		else {
			return
		}

		// source: https://stackoverflow.com/a/75712446/4118208
		NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
	}
}
