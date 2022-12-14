// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-junior-engineer-codecheck-backend",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            url: "https://github.com/swift-cloud/Compute",
            from: "1.0.0"
        ),
        .package(
            url: "https://github.com/yumemi-inc/fake-fortune-telling",
            from: "0.2.2"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "EndPoint",
            dependencies: [
                .product(name: "Compute", package: "Compute"),
                .product(name: "FakeFortuneTelling", package: "fake-fortune-telling"),
            ]),
        .testTarget(
            name: "EndPointTests",
            dependencies: ["EndPoint"]),
    ]
)
