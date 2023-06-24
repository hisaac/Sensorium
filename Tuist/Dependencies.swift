import ProjectDescription

let dependencies = Dependencies(
	swiftPackageManager: [
		.package(url: "https://github.com/sindresorhus/Defaults.git", .exact("7.2.0")),
		.package(url: "https://github.com/sindresorhus/KeyboardShortcuts.git", .exact("1.11.0")),
		.package(url: "https://github.com/sindresorhus/LaunchAtLogin-Modern.git", .exact("1.0.0")),
	],
	platforms: [.macOS]
)
