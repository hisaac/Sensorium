import AppKit
import Foundation
import Combine
import SensoriumKit

@main
struct SensoriumCLI {
	static var cancellables: Set<AnyCancellable> = []

	static func main() throws {
		NSPasteboard.general.publisher
			.compactMap(\.stringValue)
			.removeDuplicates()
			.sink { print($0) }
			.store(in: &cancellables)

		RunLoop.main.run()
	}
}
