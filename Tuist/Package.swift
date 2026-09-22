// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "FiestonVirtual",
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            exact: "11.15.0"
        )
    ]
)
