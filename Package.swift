// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReachabilityX",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "ReachabilityX",
            targets: ["ReachabilityX"]),
    ],
    dependencies: [
        .package(name: "Reachability", url: "https://github.com/ashleymills/Reachability.swift.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "ReachabilityX",
            dependencies: [
                .product(name: "Reachability", package: "Reachability")
            ]
        ),
        .testTarget(
            name: "ReachabilityXTests",
            dependencies: ["ReachabilityX"]
        ),
    ]
)
