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
            sources: [
                "FiestonVirtual/**"
            ],
            resources: [
                "FiestonVirtual/Resources/**",
                "FiestonVirtual/Preview Content/**"
            ],
            infoPlist: .file(
                path: "FiestonVirtual/Main/Info.plist"
            ),
            entitlements: .file(
                path: "FiestonVirtual/FiestonVirtual.entitlements"
            )
        ),

        .target(
            name: "FiestonVirtualTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.arpanet.fiestonvirtualTests",
            deploymentTargets: .iOS("13.7"),
            sources: [
                "FiestonVirtualTests/**"
            ]
        ),

        .target(
            name: "FiestonVirtualUITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "com.arpanet.fiestonvirtualUITests",
            deploymentTargets: .iOS("13.5"),
            sources: [
                "FiestonVirtualUITests/**"
            ]
        )
    ]
)