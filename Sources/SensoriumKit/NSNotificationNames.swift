import Cocoa

extension NSNotification.Name {
	// Working
	public static let deviceDidWake = NSWorkspace.didWakeNotification
	public static let screenIsLocked = NSNotification.Name("com.apple.screenIsLocked")
	public static let screenIsUnlocked = NSNotification.Name("com.apple.screenIsUnlocked")
	public static let screenSaverDidLaunch = NSNotification.Name("com.apple.screensaver.didlaunch")

	public static let didActivateApplication = NSWorkspace.didActivateApplicationNotification
	public static let didDeactivateApplication = NSWorkspace.didDeactivateApplicationNotification

	// Not Working
	public static let screenSaverDidStart = NSNotification.Name("com.apple.screensaver.didstart")
	public static let screenSaverDidStop = NSNotification.Name("com.apple.screensaver.didstop")
}
