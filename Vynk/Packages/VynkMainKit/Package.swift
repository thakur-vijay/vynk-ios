// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VynkMainKit",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VynkMainKit",
            targets: ["VynkMainKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", revision: "1.26.0"),
        .package(path: "../VynkUpdatesKit"),
        .package(path: "../VynkCallsKit"),
        .package(path: "../VynkCommunitiesKit"),
        .package(path: "../VynkChatsKit"),
        .package(path: "../VynkSettingsKit"),
        .package(path: "../VynkDesignSystem")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VynkMainKit",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "VynkUpdatesKit", package: "VynkUpdatesKit"),
                .product(name: "VynkCallsKit", package: "VynkCallsKit"),
                .product(name: "VynkCommunitiesKit", package: "VynkCommunitiesKit"),
                .product(name: "VynkChatsKit", package: "VynkChatsKit"),
                .product(name: "VynkSettingsKit", package: "VynkSettingsKit"),
                .product(name: "VynkDesignSystem", package: "VynkDesignSystem"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .testTarget(
            name: "VynkMainKitTests",
            dependencies: ["VynkMainKit"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
