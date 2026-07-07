// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VynkMediaKit",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VynkMediaKit",
            targets: ["VynkMediaKit"],
        ),
    ],
    dependencies: [
        .package(path: "../VynkDesignSystem"),
        .package(path: "../VynkFoundation")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VynkMediaKit",
            dependencies: [
                .product(name: "VynkDesignSystem", package: "VynkDesignSystem"),
                .product(name: "VynkFoundation", package: "VynkFoundation")
            ],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .testTarget(
            name: "VynkMediaKitTests",
            dependencies: ["VynkMediaKit"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
