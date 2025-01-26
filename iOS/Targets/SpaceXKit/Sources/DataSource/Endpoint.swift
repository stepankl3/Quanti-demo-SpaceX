import Foundation

struct Endpoint {

    let path: String
    let method: String
    let queryItems: [URLQueryItem]?
    let body: Data?
}


