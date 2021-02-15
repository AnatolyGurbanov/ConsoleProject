// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConsoleProject",
    dependencies: [
         .package(url: "https://github.com/Alamofire/Alamofire", from: "4.9.0"),
    ],
    targets: [
        .target(
            name: "ConsoleProject",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "ConsoleProjectTests",
            dependencies: ["ConsoleProject"]),
    ]
)
