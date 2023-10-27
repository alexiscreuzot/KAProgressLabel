// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "KAProgressLabel",
    products: [
        .library(
            name: "KAProgressLabel",
            targets: ["KAProgressLabel"])
    ],
    targets: [
        .target(
            name: "KAProgressLabel",
            path: "KAProgressLabel")
    ]
)
