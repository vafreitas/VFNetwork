// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VFNetwork",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "VFNetwork", targets: ["VFNetwork"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "VFNetwork",
            dependencies: [],
            path: "Sources")
    ]
)
