import SwiftUI

extension View {
	/// Applies font and color for a label used for describing a setting.
	public func settingDescription() -> some View {
		font(.system(size: 11.0))
			.foregroundStyle(.secondary)
	}
}
