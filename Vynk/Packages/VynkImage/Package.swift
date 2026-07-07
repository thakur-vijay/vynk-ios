// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VynkImage",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VynkImage",
            targets: ["VynkImage"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/kean/Nuke.git",
            from: "13.0.0"
        ),
        .package(path: "../VynkFoundation"),
        .package(path: "../VynkDesignSystem")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VynkImage",
            dependencies: [
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke"),
                .product(name: "VynkFoundation", package: "VynkFoundation"),
                .product(name: "VynkDesignSystem", package: "VynkDesignSystem")
            ],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .testTarget(
            name: "VynkImageTests",
            dependencies: ["VynkImage"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
