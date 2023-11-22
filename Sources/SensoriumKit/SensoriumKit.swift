import AppKit
import Combine

public final class SwitchBoard {
	private var cancellables: Set<AnyCancellable> = []

	public init() {}

	deinit {
		stop()
	}

	public func start(debug: Bool = false) {
		setupPasteboardSensor(debug).store(in: &cancellables)
	}

	public func stop() {
		cancellables.removeAll()
	}

	private func setupPasteboardSensor(_ debug: Bool = false) -> AnyCancellable {
		let pasteboard = NSPasteboard.general
		return pasteboard.publisher
			.compactMap(\.stringValue)
			.removeDuplicates()
			.sink { value in
				if debug {
					print("==> PasteboardSensorEvent")
					print()
					print(value)
					print()
					if let sourceAppURL = pasteboard.sourceAppURL {
						print("Source application:", sourceAppURL.lastPathComponent)
					}
					print("===============================================")
					print()
				}
			}
	}
}
