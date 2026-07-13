// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncCachedImage",
    platforms: [
        .iOS(.v17),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "AsyncCachedImage",
            targets: ["AsyncCachedImage"]
        ),
    ],
    targets: [
        .target(
            name: "AsyncCachedImage"
        ),
        .testTarget(
            name: "AsyncCachedImageTests",
            dependencies: ["AsyncCachedImage"]
        ),
    ]
)
