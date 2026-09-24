// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "FiestonVirtual",
    dependencies: [
        // Firebase
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            exact: "11.15.0"
        ),

        // Swift Package Manager
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            from: "5.2.2"
        ),
        .package(
            url: "https://github.com/hackiftekhar/IQKeyboardManager.git",
            from: "7.2.0"
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            from: "5.15.5"
        ),
        .package(
            url: "https://github.com/Q-Mobile/QGrid.git",
            from: "0.1.4"
        ),
        .package(
            url: "https://github.com/socketio/socket.io-client-swift.git",
            from: "15.2.0"
        ),
        .package(
            url: "https://github.com/exyte/Grid.git",
            from: "1.0.4"
        ),
        .package(
            url: "https://github.com/siteline/SwiftUI-Introspect.git",
            from: "0.1.1"
        ),
        .package(
            url: "https://github.com/fermoya/SwiftUIPager.git",
            from: "1.11.0"
        ),
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
            from: "5.0.0"
        ),
        .package(
            url: "https://github.com/Swinject/Swinject.git",
            from: "2.7.1"
        )
    ]
)