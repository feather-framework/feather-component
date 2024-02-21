// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-component",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "FeatherComponent", targets: ["FeatherComponent"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.0.0"),
        .package(url: "https://github.com/swift-server/swift-service-lifecycle", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "FeatherComponent",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "ServiceLifecycle", package: "swift-service-lifecycle"),
            ]
        ),
        .testTarget(
            name: "FeatherComponentTests",
            dependencies: [
                .target(name: "FeatherComponent"),
            ]
        ),
    ]
)
