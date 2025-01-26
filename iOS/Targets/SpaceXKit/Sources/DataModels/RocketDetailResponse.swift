struct RocketDetailResponse: Codable {

    let id: Int
    let rocket_name: String
    let first_flight: String
    let description: String
    let height: MeasurementResponse
    let diameter: MeasurementResponse
    let mass: MassResponse
    let first_stage: StageResponse
    let second_stage: StageResponse
    let flickr_images: [String]
}
