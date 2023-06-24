project_root := justfile_directory()
scripts_dir := project_root / "scripts"

default:
    @just --choose


### Setup ###

# Boostrap the project
bootstrap:
    @echo "Setting up..."
    {{ scripts_dir }}/tools.sh

alias up := bootstrap


### Development ###

dependencies:
    tuist fetch

generate:
    tuist generate

dev: bootstrap dependencies generate

edit:
    tuist edit

build:
    @echo "Not implemented yet"


### Utility ###

clean:
    @echo "🧹 Cleaning up local caches..."
    rm -rf {{ project_root }}/Derived
    rm -rf {{ project_root }}/DerivedData
    rm -rf {{ project_root }}/Sensorium.xcodeproj
    rm -rf {{ project_root }}/Sensorium.xcworkspace
    rm -rf {{ project_root }}/Tuist/Dependencies

nuke: clean
    @echo "☢️  Nuking global caches..."
    rm -rf $HOME/Library/Developer/Xcode/DerivedData
    rm -rf $HOME/Library/Caches/org.swift.swiftpm
    rm -rf $HOME/Library/org.swift.swiftpm
    @echo "🔥🔥🔥"
