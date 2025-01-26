import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String,
                           bundleId: String,
                           packages: [Package],
                           dependencies: [TargetDependency],
                           destinations: Destinations,
                           additionalTargets: [String]) -> Project {

        var targets = makeAppTargets(name: name,
                                     bundleId: bundleId,
                                     destinations: destinations,
                                     dependencies: dependencies + additionalTargets.map { TargetDependency.target(name: $0) })
        targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0,
                                                                    bundleId: bundleId,
                                                                    destinations: destinations,
                                                                    dependencies: dependencies) })
        return Project(name: name,
                       organizationName: "LittleBoy",
                       packages: packages,
                       targets: targets,
                       resourceSynthesizers: [.strings()])
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(name: String,
                                             bundleId: String,
                                             destinations: Destinations,
                                             dependencies: [TargetDependency]) -> [Target] {
        let sources = Target(name: name,
                             destinations: destinations,
                             product: .dynamicLibrary,
                             bundleId: "\(bundleId).\(name)",
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: ["Targets/\(name)/Resources/**"],
                             dependencies: dependencies)
        let tests = Target(name: "\(name)Tests",
                           destinations: destinations,
                           product: .unitTests,
                           bundleId: "\(bundleId).\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: ["Targets/\(name)/Resources/**"],
                           dependencies: [.target(name: name)])
        return [sources, tests]
    }

    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String,
                                       bundleId: String,
                                       destinations: Destinations,
                                       dependencies: [TargetDependency]) -> [Target] {
        let infoPlist: [String: Plist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UILaunchStoryboardName": "LaunchScreen"
        ]

        let mainTarget = Target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "\(bundleId).\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
}
