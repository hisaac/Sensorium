import SwiftUI

struct GeneralSettingsView: View {
	var body: some View {
		Form {
			VStack(alignment: .trailing) {
				HStack(alignment: .bottom) {
					Spacer()
					Button("About") {
						NSApp.orderFrontStandardAboutPanel()
					}
					Button("Quit") {
						NSApp.terminate(nil)
					}
				}
			}
		}
		.frame(width: 480, height: 300)
	}
}

#Preview {
	GeneralSettingsView()
}
