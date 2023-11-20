import AppKit
import Combine

public final class PasteboardSensor {
	private var publisher: AnyCancellable?

	private let pasteboard: NSPasteboard
	private var internatlChangeCount: Int

	public init(pasteboard: NSPasteboard = .general) {
		self.pasteboard = pasteboard
		internatlChangeCount = pasteboard.changeCount
	}

	public func start() {
		publisher = PasteboardPublisher(pasteboard: pasteboard)
			.removeDuplicates { [weak self] _, _ in
				guard let self else { return false }
				return pasteboard.changeCount == internatlChangeCount
			}
			.sink { pasteboardItems in
				print(pasteboardItems)
			}
	}

	public func stop() {
		publisher?.cancel()
	}
}

private struct PasteboardPublisher: Publisher {
	typealias Output = [NSPasteboardItem]
	typealias Failure = Never

	private let timerPublisher: AnyPublisher<Output, Failure>

	init(pasteboard: NSPasteboard) {
		timerPublisher = Timer.publish(every: 0.01, on: .main, in: .default)
			.autoconnect()
			.map { _ in pasteboard.changeCount }
			.removeDuplicates()
			.compactMap { _ in pasteboard.pasteboardItems }
			.eraseToAnyPublisher()
	}

	func receive<S>(
		subscriber: S
	) where S: Subscriber, Never == S.Failure, [NSPasteboardItem] == S.Input {
		timerPublisher.receive(subscriber: subscriber)
	}
}
