import ProjectDescription
import ProjectDescriptionHelpers

/*
                +-------------+
                |             |
                |     App     | Contains SpaceX App target and SpaceX unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

let packages: [Package] = [
    .package(url: "https://github.com/hmlongco/Factory", from: "2.4.5"),
    .package(url: "https://github.com/onevcat/Kingfisher", from: "8.0.0")
]

let dependencies: [TargetDependency] = [
    .package(product: "Factory"),
    .package(product: "Kingfisher")
]

// MARK: - Project
// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "SpaceX",
                          bundleId: "stepan.kloucek.SpaceX",
                          packages: packages,
                          dependencies: dependencies,
                          destinations: .iOS,
                          additionalTargets: ["SpaceXKit", "SpaceXUI"])

