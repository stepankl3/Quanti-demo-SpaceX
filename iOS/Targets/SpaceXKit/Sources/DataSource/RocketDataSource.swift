import Factory
import Foundation

protocol RocketDataSource {

    func getRockets() async throws -> [RocketResponse]
}

class RocketDataSourceImpl {

    // MARK: Dependecies
    @Injected(\DataSourceContainer.networkManager) var networkManager
}

extension RocketDataSourceImpl: RocketDataSource {

    func getRockets() async throws -> [RocketResponse] {
        try await networkManager.makeRequest(RocketRequest.getRockets)
    }
}
