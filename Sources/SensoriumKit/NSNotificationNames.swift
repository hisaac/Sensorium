import Cocoa

extension NSNotification.Name {
	// Working
	static let deviceDidWake = NSWorkspace.didWakeNotification
	static let screenIsLocked = NSNotification.Name("com.apple.screenIsLocked")
	static let screenIsUnlocked = NSNotification.Name("com.apple.screenIsUnlocked")
	static let screenSaverDidLaunch = NSNotification.Name("com.apple.screensaver.didlaunch")

	static let didActivateApplication = NSWorkspace.didActivateApplicationNotification
	static let didDeactivateApplication = NSWorkspace.didDeactivateApplicationNotification

	// Not Working
	static let screenSaverDidStart = NSNotification.Name("com.apple.screensaver.didstart")
	static let screenSaverDidStop = NSNotification.Name("com.apple.screensaver.didstop")
}
