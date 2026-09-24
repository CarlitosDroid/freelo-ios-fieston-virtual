import ProjectDescription

let project = Project(
    name: "FiestonVirtual",
    targets: [
        .target(
            name: "FiestonVirtual",
            destinations: .iOS,
            product: .app,
            bundleId: "com.arpanet.fiestonvirtual",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .file(
                path: "../FiestonVirtual/Info.plist"
            ),
            sources: [
                "../FiestonVirtual/Sources/**"
            ],
            resources: [
                "../FiestonVirtual/Resources/**"
            ],
            entitlements: .file(
                path: "../FiestonVirtual/Configs/FiestonVirtual.entitlements"
            ),
            dependencies: [
                .external(name: "FirebaseCore"),
                .external(name: "FirebaseMessaging"),
                .external(name: "IQKeyboardManagerSwift"),
                .external(name: "Alamofire"),
                .external(name: "KingfisherSwiftUI"),
                .external(name: "QGrid"),
                .external(name: "SocketIO"),
                .external(name: "ExyteGrid"),
                .external(name: "Introspect"),
                .external(name: "SwiftUIPager"),
                .external(name: "SwiftyJSON"),
                .external(name: "Swinject")
            ]
        ),

        .target(
            name: "FiestonVirtualTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.arpanet.fiestonvirtualTests",
            deploymentTargets: .iOS("13.7"),
            sources: [
                "../FiestonVirtualTests/**"
            ]
        ),

        .target(
            name: "FiestonVirtualUITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "com.arpanet.fiestonvirtualUITests",
            deploymentTargets: .iOS("13.5"),
            sources: [
                "../FiestonVirtualUITests/**"
            ]
        )
    ]
)