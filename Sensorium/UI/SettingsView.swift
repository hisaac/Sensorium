import SwiftUI

struct SettingsView: View {
	var body: some View {
		TabView {
			GeneralSettingsView()
				.tabItem {
					Label("General", systemImage: "gear")
				}

			DebugSettingsView()
				.tabItem {
					Label("Debug", systemImage: "figure.squash")
				}
		}
		.frame(width: 450, height: 250)
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}
