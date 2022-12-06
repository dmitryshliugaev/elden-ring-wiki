// swift-tools-version:5.7.0
import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.50.6"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
