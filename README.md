# Feather Service

The `FeatherService` library provides a basic mechanism to manage various Feather CMS related services.

## Getting started

TODO 

### Adding the dependency

To add a dependency on the package, declare it in your `Package.swift`:

```swift
.package(url: "https://github.com/feather-framework/feather-service.git", from: "1.0.0"),
```

and to your application target, add `FeatherService` to your dependencies:

```swift
.product(name: "FeatherService", package: "feather-service")
```

Example `Package.swift` file with `FeatherService` as a dependency:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "my-application",
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-service.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "MyApplication", dependencies: [
            .product(name: "FeatherService", package: "feather-service")
        ]),
        .testTarget(name: "MyApplicationTests", dependencies: [
            .target(name: "MyApplication"),
        ]),
    ]
)
```

###  Using FeatherService

See the `FeatherServiceTests` target for a basic service implementation.

