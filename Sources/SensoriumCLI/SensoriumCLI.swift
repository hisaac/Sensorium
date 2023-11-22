import Foundation
import SensoriumKit

@main
struct SensoriumCLI {
	static func main() throws {
		let switchBoard = SwitchBoard()
		switchBoard.start(debug: true)
		RunLoop.main.run()
	}
}
