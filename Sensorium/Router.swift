import Foundation

protocol Router {
	var routes: [ReactionPair] { get set }
}

protocol ReactionPair {
	var id: Int { get }
	var sensor: Sensor { get set }
	var action: Action { get set }
}

protocol SensorActionPairPersistor {
	func add(action: Action, to sensor: Sensor)
}
