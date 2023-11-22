import Foundation
import SensoriumKit
import SysInfoKit

@main
struct SensoriumCLI {
	static func main() throws {
		print(SysInfoKit.systemInfo())
		print()
		let switchBoard = SwitchBoard()
		switchBoard.start(debug: true)
		RunLoop.main.run()
	}
}
