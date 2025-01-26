import Foundation

public class RocketRepositoryMock: RocketRepository {

    public init() {}

    public func getAllRockets() async -> [Rocket] {
        return [
            Rocket(id: "1", name: "Falcon 1", firstFlight: Date(timeIntervalSince1970: 1143158400)),
            Rocket(id: "2", name: "Falcon 9", firstFlight: Date(timeIntervalSince1970: 1270512000)),
            Rocket(id: "3", name: "Falcon Heavy", firstFlight: Date(timeIntervalSince1970: 1527897600)),
            Rocket(id: "4", name: "Starship", firstFlight: Date(timeIntervalSince1970: 1610409600))
        ]
    }

    public func getRocket(id: String) async -> RocketDetail {
        return RocketDetail(
            id: "1",
            name: "Falcon 9",
            firstFlight: Date(timeIntervalSince1970: 1270512000),
            description: "A two-stage rocket designed by SpaceX for reliable transport of satellites and Dragon spacecraft.",
            heightMeters: 90,
            diameterMeters: 40,
            massKg: 40,
            firstStage: Stage(reusable: true, engines: 9, fuelAmountTons: 390, burnTimeSeconds: 162 ),
            secondStage: Stage(reusable: false, engines: 1, fuelAmountTons: 90, burnTimeSeconds: 397),
            imagesUrl: []
        )
    }
}
