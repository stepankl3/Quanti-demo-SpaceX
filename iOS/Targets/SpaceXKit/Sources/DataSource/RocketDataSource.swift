import Factory
import Foundation

protocol RocketDataSource {

    func getRockets() async throws -> [RocketResponse]
    func getRocket(id: String) async throws -> RocketDetailResponse
}

final class RocketDataSourceImpl {

    // MARK: Dependecies
    @Injected(\DataSourceContainer.networkManager) var networkManager
}

// MARK: - Protocol conformace
extension RocketDataSourceImpl: RocketDataSource {

    func getRockets() async throws -> [RocketResponse] {
        try await networkManager.makeRequest(RocketRequest.getRockets)
    }

    func getRocket(id: String) async throws -> RocketDetailResponse {
        try await networkManager.makeRequest(RocketRequest.getRocket(id: id))
    }
}
