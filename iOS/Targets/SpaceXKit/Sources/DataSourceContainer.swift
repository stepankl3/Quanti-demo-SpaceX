import Factory
import Foundation

final class DataSourceContainer: SharedContainer {

    static let shared = DataSourceContainer()

    let manager: ContainerManager = {
        let manager = ContainerManager()
        manager.defaultScope = .cached
        return manager
    }()

    var networkManager: Factory<NetworkManager> {
        self { NetworkManager(baseUrl: URL(string: "https://api.spacexdata.com/v3")!) }
    }

    var rocketDataSource: Factory<RocketDataSource> {
        self { RocketDataSourceImpl() }
    }
}


