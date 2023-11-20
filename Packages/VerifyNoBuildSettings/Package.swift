// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "VerifyNoBuildSettings",
	products: [
		.executable(
			name: "VerifyNoBuildSettings",
			targets: ["VerifyNoBuildSettings"]
		),
		.plugin(
			name: "VerifyNoBuildSettingsPlugin",
			targets: ["VerifyNoBuildSettingsPlugin"]
		),
	],
	dependencies: [
		.package(
			url: "https://github.com/tuist/XcodeProj",
			from: "8.15.0"
		),
	],
	targets: [
		.executableTarget(
			name: "VerifyNoBuildSettings",
			dependencies: [
				.product(name: "XcodeProj", package: "XcodeProj"),
			]
		),
		.plugin(
			name: "VerifyNoBuildSettingsPlugin",
			capability: .buildTool(),
			dependencies: ["VerifyNoBuildSettings"]
		),
	]
)
