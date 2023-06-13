import LaunchAtLogin
import SwiftUI

struct GeneralSettingsView: View {
	var body: some View {
		Form {
			LabeledContent("Behavior:") {
				LaunchAtLogin.Toggle()
			}
			VStack(alignment: .trailing) {
				HStack {
					Spacer()
					Button("About") {
						NSApp.orderFrontStandardAboutPanel(
							options: [
								.applicationIcon: NSWorkspace.shared.icon(forFile: Bundle.main.bundlePath),
								.credits: "Credits Placeholder"
							]
						)
					}
					Button("Quit") {
						NSApp.terminate(nil)
					}
				}
			}
		}
	}
}

struct GeneralSettingsView_Previews: PreviewProvider {
	static var previews: some View {
		GeneralSettingsView()
	}
}
