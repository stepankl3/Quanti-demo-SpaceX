import Foundation
import SpaceXKit
import Factory

@MainActor
public protocol RocketDetailScreenViewModel: ObservableObject {

    var screenState: RocketDetailScreenState { get }
    func onAppear()
    func onLaunchTapped()
}

// MARK: - Screen State Enum
public enum RocketDetailScreenState {
    case loading
    case error
    case data(detail: RocketDetail)
}

// MARK: - ViewModel Implementation
@MainActor
public class RocketDetailScreenViewModelImpl {

    // MARK: - Dependencies
    @Injected(\RepositoriesContainer.rocketRepository) var repository: RocketRepository
    private let rocketId: String

    // MARK: - Properties
    @Published public var screenState: RocketDetailScreenState = .loading

    // MARK: - Init
    public init(rocketId: String) {
        self.rocketId = rocketId
    }

    public func loadRocketDetail() {
        Task {
            do {
                screenState = .loading
                let detail = try await repository.getRocket(id: rocketId)
                screenState = .data(detail: detail)
            } catch {
                screenState = .error
            }
        }
    }
}

// MARK: - Protocol Conformance
extension RocketDetailScreenViewModelImpl: RocketDetailScreenViewModel {

    public func onLaunchTapped() {
        print("Launch tapped")
    }
    

    public func onAppear() {
        loadRocketDetail()
    }
}
