import SwiftUI

struct SettingsView: View {
	var body: some View {
		TabView {
			GeneralSettingsView()
				.tabItem {
					Label("General", systemImage: "gear")
				}
		}.scenePadding()
	}
}

#Preview {
	SettingsView()
}
