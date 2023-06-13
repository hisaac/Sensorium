import Defaults
import LaunchAtLogin
import SwiftUI

struct SettingsView: View {
	var body: some View {
		TabView {
			GeneralSettingsView()
				.tabItem {
					Label("General", systemImage: "gear")
				}
				.tag(1)

			DebugSettingsView()
				.tabItem {
					Label("Debug", systemImage: "figure.squash")
				}
				.tag(2)
		}
		.frame(width: 480, height: 300)
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}
