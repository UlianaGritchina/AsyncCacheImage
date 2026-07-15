// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncCacheImage",
    platforms: [
        .iOS(.v17),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "AsyncCacheImage",
            targets: ["AsyncCacheImage"]
        ),
    ],
    targets: [
        .target(
            name: "AsyncCacheImage"
        ),
        .testTarget(
            name: "AsyncCacheImageTests",
            dependencies: ["AsyncCacheImage"]
        ),
    ]
)
