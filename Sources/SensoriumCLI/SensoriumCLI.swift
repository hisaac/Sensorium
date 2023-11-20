import Foundation
import SensoriumKit

@main
struct SensoriumCLI {
	static func main() throws {
//		let pasteboardSensor = PasteboardSensor()
//		pasteboardSensor.start()

		let pasteboardSensor2 = PasteboardSensor2()

		RunLoop.main.run()
	}
}
