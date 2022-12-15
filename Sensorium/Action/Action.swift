import Combine

protocol Action {
	var name: String { get }
	var friendlyName: String { get }
	var description: String { get }

	func perform(event: SensedEvent)
}
