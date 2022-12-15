import AppKit
import Combine

final class PasteboardSensor: Sensor {
	let friendlyName = "Pasteboard Sensor"
	let description = "Senses for changes to the global pasteboard"

	let publisher: any Publisher

	init(pasteboard: NSPasteboard) {
		publisher = PasteboardPublisher(pasteboard: pasteboard)
	}

	struct PasteboardPublisher: Publisher {
		typealias Output = [NSPasteboardItem]
		typealias Failure = Never

		private let timerPublisher: AnyPublisher<Output, Failure>

		init(pasteboard: NSPasteboard) {
			timerPublisher = Timer.publish(every: 0.01, on: .main, in: .default)
				.autoconnect()
				.map { _ in pasteboard.changeCount }
				.removeDuplicates()
				.map { _ in pasteboard.pasteboardItems ?? [] }
				.eraseToAnyPublisher()
		}

		func receive<S>(
			subscriber: S
		) where S: Subscriber, S.Failure == Failure, S.Input == Output {
			timerPublisher.receive(subscriber: subscriber)
		}
	}
}
