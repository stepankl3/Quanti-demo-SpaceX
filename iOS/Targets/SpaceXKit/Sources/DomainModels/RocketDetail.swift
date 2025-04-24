import Foundation

public struct RocketDetail: Sendable {

    public let id: String
    public let name: String
    public let firstFlight: Date
    public let description: String
    public let heightMeters: Double
    public let diameterMeters: Double
    public let massKg: Int
    public let firstStage: Stage
    public let secondStage: Stage
    public let imagesUrl: [URL]
}
