import AppKit
import Foundation
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	private var window: NSWindow!
	private var windowController: NSWindowController!

	func applicationDidFinishLaunching(_ notification: Notification) {
		window = NSWindow(
			contentRect: NSRect.zero,
			styleMask: [.closable, .titled],
			backing: .buffered,
			defer: true
		)

		window.title = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Sensorium"
		window.contentView = NSHostingView(rootView: SettingsView())
		windowController = NSWindowController(window: window)

		openSettingsWindow()
	}

	func openSettingsWindow() {
		// Works around an annoyance where the app always comes to the foreground
		// when being previewed in Xcode's SwiftUI Canvas
		guard
			ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1"
		else {
			return
		}

		windowController.window?.center()
		windowController.showWindow(self)

		if #available(macOS 14, *) {
			NSApp.activate()
		} else {
			NSApp.activate(ignoringOtherApps: true)
		}
	}
}
