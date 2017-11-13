// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftCodeWriter",
    products: [
        .library(
            name: "SwiftCodeWriter",
            targets: ["SwiftCodeWriter"])
    ],
    dependencies: [
        .package(url: "https://github.com/Digipolitan/code-writer.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SwiftCodeWriter",
            dependencies: ["CodeWriter"]),
        .testTarget(
            name: "SwiftCodeWriterTests",
            dependencies: ["SwiftCodeWriter"])
    ]
)
