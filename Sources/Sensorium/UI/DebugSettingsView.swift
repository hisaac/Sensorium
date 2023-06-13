import Defaults
import SwiftUI

struct DebugSettingsView: View {
	@State private var logText = ""

	var body: some View {
		VStack {
			Defaults.Toggle("Display Debug Logs", key: .debugLoggingEnabled)
		}
	}
}

struct DebugSettingsView_Previews: PreviewProvider {
	static var previews: some View {
		DebugSettingsView()
	}
}
