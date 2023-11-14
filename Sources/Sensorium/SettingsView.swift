import SwiftUI

struct SettingsView: View {
	var body: some View {
		TabView {
			GeneralSettingsView()
				.tabItem {
					Label("General", systemImage: "gear")
				}
				.tag(1)
		}
	}
}

#Preview {
	SettingsView()
}
