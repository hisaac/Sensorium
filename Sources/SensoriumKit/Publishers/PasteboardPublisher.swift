import AppKit
import Combine

extension NSPasteboard {
	public typealias PasteboardPublisher = AnyPublisher<NSPasteboard, Never>

	public var publisher: PasteboardPublisher {
		return Timer.publish(every: 0.01, on: .main, in: .default)
			.autoconnect()
			.compactMap { [weak self] _ in self?.changeCount }
			.removeDuplicates()
			.compactMap { [weak self] _ in self }
			.eraseToAnyPublisher()
	}
}

extension NSPasteboard {
	public var sourceAppBundleIdentifier: String? {
		if let bundleID = string(forType: .sourceAppBundleIdentifier) {
			return bundleID
		} else {
			return NSWorkspace.shared.frontmostApplication?.bundleIdentifier
		}
	}

	public var sourceAppURL: URL? {
		guard let sourceAppBundleIdentifier else { return nil }
		return NSWorkspace.shared.urlForApplication(withBundleIdentifier: sourceAppBundleIdentifier)
	}

	public var stringValue: String? {
		string(forType: .string)
	}
}

extension NSPasteboard.PasteboardType {
	/// Convention for getting the bundle identifier of the source app.
	///
	/// > This marker’s presence indicates that the source of the content is the application with the bundle identifier matching its UTF–8 string content. For example: `pasteboard.setString("com.sindresorhus.Foo" forType: "org.nspasteboard.source")`. This is useful when the source is not the foreground application. This is meant to be shown to the user by a supporting app for informational purposes only. Note that an empty string is a valid value as explained below.
	/// > - http://nspasteboard.org
	static let sourceAppBundleIdentifier = Self("org.nspasteboard.source")
}
