// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VynkQRCodeKit",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VynkQRCodeKit",
            targets: ["VynkQRCodeKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", revision: "1.26.0"),
        .package(path: "../VynkDesignSystem"),
        .package(path: "../VynkFoundation"),
        .package(path: "../VynkImage"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VynkQRCodeKit",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "VynkDesignSystem", package: "VynkDesignSystem"),
                .product(name: "VynkFoundation", package: "VynkFoundation"),
                .product(name: "VynkImage", package: "VynkImage"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .testTarget(
            name: "VynkQRCodeKitTests",
            dependencies: ["VynkQRCodeKit"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
