import AppKit
import SwiftUI

@main
final class AppDelegate: NSObject, NSApplicationDelegate {
	private var window: NSWindow!

	func applicationDidFinishLaunching(_ notification: Notification) {
		let contentView = NSHostingView(rootView: SettingsView())
		let contentSize = contentView.fittingSize
		let windowRect = NSRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)

		window = NSWindow(
			contentRect: windowRect,
			styleMask: [.closable, .titled],
			backing: .buffered,
			defer: true
		)

		window.title = "Sensorium"
		window.contentView = contentView

		openSettingsWindow()
	}

	private func openSettingsWindow() {
		// Works around an annoyance where the app always comes to the foreground
		// when being previewed in Xcode's SwiftUI Canvas
		guard
			ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1"
		else {
			return
		}

		window.center()
		window.makeKeyAndOrderFront(nil)

		if #available(macOS 14, *) {
			NSApp.activate()
		} else {
			NSApp.activate(ignoringOtherApps: true)
		}
	}
}
