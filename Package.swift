// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-service",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "FeatherService", targets: ["FeatherService"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.5.0"),
    ],
    targets: [
        .target(
            name: "FeatherService",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
        .testTarget(
            name: "FeatherServiceTests",
            dependencies: [
                .target(name: "FeatherService"),
            ]
        ),
    ]
)
