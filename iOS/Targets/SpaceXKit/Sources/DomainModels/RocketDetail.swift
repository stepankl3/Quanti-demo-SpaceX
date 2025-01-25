import Foundation

public struct RocketDetail {
    public let id: UUID = UUID()
    public let name: String
    public let firstFlight: Date
    public let description: String
    public let height: String
    public let diameter: String
    public let mass: String
    public let firstStage: Stage
    public let secondStage: Stage
    public let imagesUrl: [String]
}
