// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "API",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .visionOS(.v1),
        .watchOS(.v10)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "API",
            targets: ["API"]),
    ],
    dependencies: [
        .package(path: "../Cache"),
        .package(url: "https://github.com/kean/Get.git", from: .init(2, 1, 6))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "API",
            dependencies: [
                "Cache",
                .product(name: "Get", package: "Get")
            ],
            path: "src"
        )
    ]
)
