import Foundation
import XcodeProj

@main
struct VerifyNoBuildSettings {
	static func main() throws {
		guard let projectFilePath = CommandLine.arguments[safe: 1] else { return }

		var allowedSettings: [String] = ["CODE_SIGN_ENTITLEMENTS"]

		if let allowedSettingsArg = CommandLine.arguments[safe: 2] {
			allowedSettings.append(contentsOf: allowedSettingsArg.components(separatedBy: " "))
		}

		let project = try XcodeProj(pathString: projectFilePath)
		for configuration in project.pbxproj.buildConfigurations {
			for setting in configuration.buildSettings where allowedSettings.contains(setting.key) == false {
				print("error: Build setting \(setting.key) found in \(configuration.name) inside \(projectFilePath)")
			}
		}
	}
}

extension Collection {
	/// Returns the element at the specified index if it is within bounds, otherwise nil.
	subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
