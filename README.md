# Feather Component

The `FeatherComponent` library provides a basic mechanism to manage various Feather CMS related components.

## Getting started

⚠️ This repository is a work in progress, things can break until it reaches v1.0.0. 

Use at your own risk.

### Adding the dependency

To add a dependency on the package, declare it in your `Package.swift`:

```swift
.package(url: "https://github.com/feather-framework/feather-component", .upToNextMinor(from: "0.4.0")),
```

and to your application target, add `FeatherComponent` to your dependencies:

```swift
.product(name: "FeatherComponent", package: "feather-component")
```

Example `Package.swift` file with `FeatherComponent` as a dependency:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "my-application",
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-component", .upToNextMinor(from: "0.4.0")),
    ],
    targets: [
        .target(name: "MyApplication", dependencies: [
            .product(name: "FeatherComponent", package: "feather-component")
        ]),
        .testTarget(name: "MyApplicationTests", dependencies: [
            .target(name: "MyApplication"),
        ]),
    ]
)
```

###  Using FeatherComponent

See the `FeatherComponentTests` target for a basic component implementation.

