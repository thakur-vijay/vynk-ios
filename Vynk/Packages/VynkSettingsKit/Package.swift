// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VynkSettingsKit",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VynkSettingsKit",
            targets: ["VynkSettingsKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", revision: "1.26.0"),
        .package(path: "../VynkDesignSystem"),
        .package(path: "../VynkImage"),
        .package(path: "../VynkChatLists"),
        .package(path: "../VynkQRCodeKit"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VynkSettingsKit",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "VynkDesignSystem", package: "VynkDesignSystem"),
                .product(name: "VynkImage", package: "VynkImage"),
                .product(name: "VynkChatLists", package: "VynkChatLists"),
                .product(name: "VynkQRCodeKit", package: "VynkQRCodeKit"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .testTarget(
            name: "VynkSettingsKitTests",
            dependencies: ["VynkSettingsKit"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
