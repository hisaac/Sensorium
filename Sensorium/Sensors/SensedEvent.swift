import Foundation

protocol SensedEvent: CustomDebugStringConvertible {
	var name: String { get }
	var description: String { get }
	var info: [AnyHashable: Any]? { get }
}

extension SensedEvent {
	var debugDescription: String {
		var description = """
			Name: \(name)
			Description: \(description)
			"""

		if let eventInfo = info, eventInfo.isEmpty == false {
			eventInfo.forEach { key, value in
				description.append("\n")
				description.append("\(key): \(value)")
			}
		}

		return description
	}
}
