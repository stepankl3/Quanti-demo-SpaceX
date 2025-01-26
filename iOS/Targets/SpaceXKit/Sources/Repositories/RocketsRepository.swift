import Factory
import Foundation

public protocol RocketRepository {

    func getAllRockets() async throws -> [Rocket]
    func getRocket(id: String) async throws -> RocketDetail
}


public class RocketRepositoryImpl {
    // MARK: - Dependencies
    @Injected(\DataSourceContainer.rocketDataSource) var rocketDataSource

}

extension RocketRepositoryImpl: RocketRepository {

    public func getAllRockets() async throws -> [Rocket] {
        let rocketResponse = try await rocketDataSource.getRockets()
        
        return rocketResponse.compactMap {
            guard let firstFlightDate = $0.first_flight.parseApiDate() else {
                return nil
            }
            return Rocket(id: $0.rocket_id,
                          name: $0.rocket_name,
                          firstFlight: firstFlightDate)
        }

    }

    public func getRocket(id: String) async throws -> RocketDetail {
        throw NSError(domain: "NotImplemented", code: 1)
    }
}
