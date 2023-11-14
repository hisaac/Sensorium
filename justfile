project_root := justfile_directory()
scripts_dir := project_root / "scripts"

default:
	@just --choose


### Setup ###

# Boostrap the project
bootstrap:
	@echo "Setting up..."
	{{ scripts_dir }}/tools.sh
	{{ scripts_dir }}/set-local-derived-data.sh {{ project_root }}/Sensorium.xcodeproj
	xcodes select

alias up := bootstrap


### Development ###

dev: bootstrap open

open:
	xcrun xed {{ project_root }}/Sensorium.xcodeproj


### Utility ###

clean:
	@echo "🧹 Cleaning up local caches..."
	rm -rf {{ project_root }}/DerivedData

nuke: clean
	@echo "☢️  Nuking global caches..."
	rm -rf $HOME/Library/Developer/Xcode/DerivedData
	rm -rf $HOME/Library/Caches/org.swift.swiftpm
	rm -rf $HOME/Library/org.swift.swiftpm
	@echo "🔥🔥🔥"
