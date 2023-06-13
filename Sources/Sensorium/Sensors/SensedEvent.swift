import Foundation

protocol SensedEvent: CustomDebugStringConvertible {
	var name: String { get }
	var info: [AnyHashable: Any]? { get }
}

extension SensedEvent {
	var name: String { #file }

	var debugDescription: String {
		var description = "Name: \(name)"

		if let eventInfo = info, eventInfo.isEmpty == false {
			eventInfo.forEach { key, value in
				description.append("\n")
				description.append("\(key): \(value)")
			}
		}

		return description
	}
}
