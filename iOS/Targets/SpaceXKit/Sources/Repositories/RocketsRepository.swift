import Foundation

public protocol RocketRepository {

    func getAllRockets() async throws -> [Rocket]
    func getRocket(id: String) async throws -> RocketDetail
}


public class RocketRepositoryImpl {

}

extension RocketRepositoryImpl: RocketRepository {

    public func getAllRockets() async throws -> [Rocket] {
        throw NSError(domain: "NotImplemented", code: 1)
    }

    public func getRocket(id: String) async throws -> RocketDetail {
        throw NSError(domain: "NotImplemented", code: 1)
    }
}
