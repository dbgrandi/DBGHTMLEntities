// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "DBGHTMLEntities",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "DBGHTMLEntities",
            targets: ["DBGHTMLEntities"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DBGHTMLEntities",
            path: "Classes"),
    ]
)
