import Foundation

enum RocketRequest {

    static var getRockets: Endpoint {
        return Endpoint(
            path: "rockets",
            method: "GET",
            queryItems: [
                URLQueryItem(name: "filter",
                             value: "rocket_id,rocket_name,rocket_type,first_flight")
            ],
            body: nil
        )
    }
}
