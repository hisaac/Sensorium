import Foundation
import PackagePlugin
import XcodeProjectPlugin

@main
struct VerifyNoBuildSettingsPlugin: BuildToolPlugin, XcodeBuildToolPlugin {
	let packageName = "VerifyNoBuildSettings"
	let fileManager = FileManager.default

	func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
		let projectRootContents = try FileManager.default.contentsOfDirectory(
			atPath: context.xcodeProject.directory.string
		)
		let xcworkspace = projectRootContents.first { $0.hasSuffix(".xcworkspace") }
		let xcodeproj = projectRootContents.first { $0.hasSuffix(".xcodeproj") }
		guard let projectFilePath = xcworkspace ?? xcodeproj else { return [] }

		return [
			.buildCommand(
				displayName: packageName,
				executable: try context.tool(named: packageName).path,
				arguments: [projectFilePath]
			)
		]
	}

	func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
		print("\(packageName) is only meant to be run within Xcode projects")
		return []
	}
}
