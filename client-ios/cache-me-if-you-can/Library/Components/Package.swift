// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .visionOS(.v1),
        .watchOS(.v10)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Components",
            targets: ["Components"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/kean/Nuke.git", from: .init(12, 1, 6)),
        .package(path: "../API"),
        .package(path: "../Cache"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Components",
            dependencies: [
                "Atoms",
                "Molecules",
                "Organisms",
                "Templates",
                "Pages",
                "Features",
                "Modules"
            ],
            path: "0-Components/src"
        ),
        .target(
            name: "Atoms",
            dependencies: [
                "ComponentsCommon"
            ],
            path: "1-Atoms/src"
        ),
        .target(
            name: "Molecules",
            dependencies: [
                "ComponentsCommon",
                "Atoms"
            ],
            path: "2-Molecules/src"
        ),
        .target(
            name: "Organisms",
            dependencies: [
                .product(name: "Nuke", package: "Nuke"),
                "ComponentsCommon",
                "Atoms",
                "Molecules"
            ],
            path: "3-Organisms/src"
        ),
        .target(
            name: "Templates",
            dependencies: [
                "ComponentsCommon",
                "Atoms",
                "Molecules",
                "Organisms"
            ],
            path: "4-Templates/src"
        ),
        .target(
            name: "Pages",
            dependencies: [
                "ComponentsCommon",
                "API",
                "Cache",
                "Atoms",
                "Molecules",
                "Organisms",
                "Templates"
            ],
            path: "5-Pages/src"
        ),
        .target(
            name: "Features",
            dependencies: [
                "ComponentsCommon",
                "Atoms",
                "Molecules",
                "Organisms",
                "Templates",
                "Pages"
            ],
            path: "6-Features/src"
        ),
        .target(
            name: "Modules",
            dependencies: [
                "ComponentsCommon",
                "Atoms",
                "Molecules",
                "Organisms",
                "Templates",
                "Pages",
                "Features"
            ],
            path: "7-Modules/src"
        ),
        .target(
            name: "ComponentsCommon",
            dependencies: [
                "Cache"
            ],
            path: "Common/src"
        )
    ]
)
