// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VynkChatLists",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VynkChatLists",
            targets: ["VynkChatLists"]
        ),
    ],
    dependencies: [
        .package(path: "../VynkDatabaseKit"),
        .package(path: "../VynkDesignSystem"),
        .package(path: "../VynkFoundation"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", revision: "1.26.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VynkChatLists",
            dependencies: [
                .product(name: "VynkDatabaseKit", package: "VynkDatabaseKit"),
                .product(name: "VynkDesignSystem", package: "VynkDesignSystem"),
                .product(name: "VynkFoundation", package: "VynkFoundation"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .testTarget(
            name: "VynkChatListsTests",
            dependencies: ["VynkChatLists"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
