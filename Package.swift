// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OfflineEssentials",
    platforms: [
        .iOS(.v16) // Specifies iOS 16.0 or newer
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OfflineEssentials",
            targets: ["OfflineEssentials"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OfflineEssentials"),
        .testTarget(
            name: "OfflineEssentialsTests",
            dependencies: ["OfflineEssentials"]),
    ]
)
