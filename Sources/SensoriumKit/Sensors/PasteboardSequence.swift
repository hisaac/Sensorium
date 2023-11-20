import AppKit
import Combine
import AsyncAlgorithms

public final class PasteboardSensor2 {
	private let pasteboard: NSPasteboard

	private var cancellables = Set<AnyCancellable>()

	public init(pasteboard: NSPasteboard = .general) {
		self.pasteboard = pasteboard
		setup()
	}

	deinit {
		print("deinit!")
		cancellables.removeAll()
	}

	func setup() {
		Task { [weak self] in
			guard let self else { return }
			var internalChangeCount = 0
			let timerSequence = AsyncTimerSequence(
				interval: .milliseconds(1),
				clock: ContinuousClock()
			)
			for await _ in timerSequence {
				if pasteboard.changeCount != internalChangeCount,
				   let pasteboardItems = pasteboard.pasteboardItems {
					internalChangeCount = pasteboard.changeCount
					for item in pasteboardItems {
						print(pasteboard.string(forType: .string))
					}
				}
			}
		}.store(in: &cancellables)
	}
}

extension Task {
	func store(in cancellables: inout Set<AnyCancellable>) {
		asCancellable().store(in: &cancellables)
	}

	func asCancellable() -> AnyCancellable {
		.init { self.cancel() }
	}
}

extension NSPasteboard.PasteboardType {
	static let sourceAppBundleIdentifier = Self("org.nspasteboard.source")
}

extension NSPasteboard {
	struct ContentsInfo: Equatable, Identifiable {
		let id = UUID()
		let created = Date()
		let sourceAPpBundleIdentifier: String?
		let sourceAppURL: URL?
	}

	var publisher: AnyPublisher<ContentsInfo, Never> {
		var isFirstCheck = true

		return Timer.publish(every: 0.01, on: .main, in: .default)
			.autoconnect()
			.prepend([Date()])
			.compactMap { [weak self] _ in
				self?.changeCount
			}
			.removeDuplicates()
			.compactMap { [weak self] _ -> ContentsInfo? in
				defer {
					if isFirstCheck {
						isFirstCheck = false
					}
				}

				guard
					let self,
					let source = string(forType: .sourceAppBundleIdentifier)
				else {
					return nil
				}
				return nil
			}
			.eraseToAnyPublisher()
	}
}
