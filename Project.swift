import ProjectDescription

let project = Project(
	name: "Sensorium",
	options: .options(textSettings: .textSettings(usesTabs: true)),
	settings: .settings(
		base: [
			"CLANG_CXX_LANGUAGE_STANDARD": "gnu++20",
			"MACOSX_DEPLOYMENT_TARGET": "13.3",
			"SDKROOT": "macosx",
		],
		debug: [
			"SWIFT_ACTIVE_COMPILATION_CONDITIONS": "DEBUG",
			"SWIFT_OPTIMIZATION_LEVEL": "-Onone", // No Optimization
		],
		release: [
			"SWIFT_ACTIVE_COMPILATION_CONDITIONS": "RELEASE",
			"SWIFT_COMPILATION_MODE": "wholemodule",
		],
		defaultSettings: .recommended(
			excluding: [
				"CLANG_CXX_LIBRARY",
				"MTL_ENABLE_DEBUG_INFO",
				"PRODUCT_NAME",
			]
		)
	),
	targets: [
		Target(
			name: "Sensorium",
			platform: .macOS,
			product: .app,
			bundleId: "net.hisaac.Sensorium",
			sources: "Sources/Sensorium/Sources/**",
			resources: "Sources/Sensorium/Resources/**",
			entitlements: "Sources/Sensorium/Sensorium.entitlements",
			dependencies: [
				.external(name: "Defaults"),
				.external(name: "KeyboardShortcuts"),
				.external(name: "LaunchAtLogin"),
			],
			settings: .settings(
				base: [
					"ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
					"DEVELOPMENT_ASSET_PATHS": #"Sources/Sensorium/Resources/Preview\ Content"#,
					"ENABLE_HARDENED_RUNTIME": "YES",
				],
				defaultSettings: .recommended(
					excluding: [
						"SDKROOT",
						"SWIFT_ACTIVE_COMPILATION_CONDITIONS",
						"SWIFT_COMPILATION_MODE",
						"SWIFT_OPTIMIZATION_LEVEL",
					]
				)
			)
		),
		Target(
			name: "SensoriumTests",
			platform: .macOS,
			product: .unitTests,
			bundleId: "net.hisaac.SensoriumTests",
			sources: "Sources/Sensorium/Tests/**",
			dependencies: [
				.target(name: "Sensorium"),
			],
			settings: .settings(
				base: [
					"SWIFT_EMIT_LOC_STRINGS": "NO",
				],
				defaultSettings: .recommended(
					excluding: [
						"SDKROOT",
						"SWIFT_ACTIVE_COMPILATION_CONDITIONS",
						"SWIFT_COMPILATION_MODE",
						"SWIFT_OPTIMIZATION_LEVEL",
					]
				)
			)
		)
	],
	fileHeaderTemplate: "",
	additionalFiles: [
		".github",
		".gitignore",
		"LICENSE",
		"Makefile",
		"Project.swift",
		"README.md",
		"scripts/**",
		"Tuist",
	]
)
