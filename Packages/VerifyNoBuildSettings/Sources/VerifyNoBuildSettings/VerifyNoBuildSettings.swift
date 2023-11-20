import Foundation
import XcodeProj

@main
struct VerifyNoBuildSettings {
	static func main() throws {
		guard let projectFilePath = CommandLine.arguments.dropFirst().first else {
			return
		}

		let project = try XcodeProj(pathString: projectFilePath)
		guard let buildConfigurationList = project.pbxproj.rootObject?.buildConfigurationList else {
			return
		}

		for configuration in buildConfigurationList.buildConfigurations {
			for setting in configuration.buildSettings {
				print("error: Build setting \(setting.key) found in \(configuration.name) inside \(projectFilePath)")
			}
		}
	}
}
