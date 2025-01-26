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
        let rocketDetailResponse = try await rocketDataSource.getRocket(id: id)

        guard let firstFlightDate = rocketDetailResponse.first_flight.parseApiDate() else {
            throw NetworkError.invalidResponse
        }

        return RocketDetail(
            id: id,
            name: rocketDetailResponse.rocket_name,
            firstFlight: firstFlightDate,
            description: rocketDetailResponse.description,
            heightMeters: rocketDetailResponse.height.meters,
            diameterMeters: rocketDetailResponse.diameter.meters,
            massKg: rocketDetailResponse.mass.kg,
            firstStage: rocketDetailResponse.first_stage.toStage(),
            secondStage: rocketDetailResponse.second_stage.toStage(),
            imagesUrl: rocketDetailResponse.flickr_images.compactMap { URL(string: $0)}
        )
    }
}
