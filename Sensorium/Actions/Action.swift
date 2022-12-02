import Foundation

protocol Action {
	var name: String { get }
	var description: String { get }

	func perform()
}
