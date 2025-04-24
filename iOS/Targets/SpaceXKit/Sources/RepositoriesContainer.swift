import Factory

final public class RepositoriesContainer: SharedContainer {

    static public let shared = RepositoriesContainer()

    public let manager: ContainerManager = {
        let manager = ContainerManager()
        manager.defaultScope = .cached
        return manager
    }()
}

// MARK: - App runtime living repositories
extension RepositoriesContainer {

    public var rocketRepository: Factory<RocketRepository> {
        self { RocketRepositoryImpl() }
            .onPreview { RocketRepositoryMock() }
    }
}
