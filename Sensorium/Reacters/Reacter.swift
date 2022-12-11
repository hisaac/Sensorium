import Combine

protocol Reacter {
	var name: String { get }
	var friendlyName: String { get }
	var description: String { get }

	var subscriber: any Subscriber { get }
}
