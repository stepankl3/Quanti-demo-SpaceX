import Foundation

final class NetworkManager {

    // MARK: - Properties
    private let baseURL: URL

    // MARK: - Init
    init(baseUrl: URL) {
        self.baseURL = baseUrl
    }

    // MARK: - Request
    func makeRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint.path),
                                          resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = endpoint.queryItems

        guard let url = urlComponents?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
