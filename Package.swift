// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "EPISDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "EPISDK",
            targets: ["EPINetworking"]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "EPINetworking",
            path: "Frameworks/EPINetworking.xcframework"
        )
    ]
)
