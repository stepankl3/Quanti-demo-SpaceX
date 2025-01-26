struct StageResponse: Codable {

    let reusable: Bool
    let engines: Int
    let fuel_amount_tons: Double
    let burn_time_sec: Double?
}

extension StageResponse {

    func toStage() -> Stage {
        Stage(reusable: reusable,
              engines: engines,
              fuelAmountTons: fuel_amount_tons,
              burnTimeSeconds: burn_time_sec)
    }
}
