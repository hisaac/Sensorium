import Combine

final class LogAction: Action {
	let name = #file
	let friendlyName = "Log Action"
	let description = "Action for logging events"

	func perform(event: SensedEvent) {
		print(event)
	}
}
