@testable import Sensorium

import XCTest

final class PasteboardSensorTests: XCTestCase {
	var testPasteboard: NSPasteboard!

	override func setUpWithError() throws {
		testPasteboard = NSPasteboard.withUniqueName()
	}

	override func tearDownWithError() throws {
		testPasteboard.releaseGlobally()
	}

	func testPublishOnPasteboardChange() throws {
		// Given
		var changeCount = testPasteboard.changeCount // 0
		_ = testPasteboard.publisher()
			.sink { _ in
				changeCount += 1 // 1
			}

		// When
		XCTAssertTrue(testPasteboard.writeObjects([]))

		// Then
		XCTAssertEqual(changeCount, testPasteboard.changeCount)
	}
}

// Extend `NSPasteboard` to add a convenience method for creating a default publisher
extension NSPasteboard {
	/// A convenience method for creating a `PasteboardPublisher` for this `NSPasteboard`
	/// - Returns: A `PasteboardPublisher` for this `NSPasteboard`
	public func publisher() -> PasteboardSensor.PasteboardPublisher {
		return PasteboardSensor.PasteboardPublisher(pasteboard: self)
	}
}
