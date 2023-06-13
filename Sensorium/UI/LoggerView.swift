import SwiftUI
import os.log
import OSLog

struct LoggerView: View {
	let logger = Logger.development

	var body: some View {
		Text("")
	}
}

struct LoggerView_Previews: PreviewProvider {
	static var previews: some View {
		LoggerView()
	}
}

extension Logger {
	private static var subsystem = Bundle.main.bundleIdentifier!

	static let development = Logger(subsystem: subsystem, category: "development")
}
