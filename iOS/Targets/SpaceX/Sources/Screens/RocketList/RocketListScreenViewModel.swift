import Factory
import Foundation
import SpaceXKit

@MainActor
protocol RocketListScreenViewModel: ObservableObject {

    var screenState: RocketListScreenState { get }
    var selectedRocketId: String? { get set }

    func onErrorTap()
    func onAppear()
    func onRocketTap(rocketId: String)
    func onPullToRefresh() async
}

enum RocketListScreenState {
    case error
    case loading
    case data(rockets: [Rocket])
}

@MainActor
class RocketListScreenViewModelImpl: ObservableObject {

    // MARK: - Dependencies
    @Injected(\RepositoriesContainer.rocketRepository) var rocketRepository
    // MARK: - Properties
    @Published var screenState: RocketListScreenState = .loading
    @Published var selectedRocketId: String?


    // MARK: - Util functions
    func loadRockets() {
        Task { [rocketRepository] in
            do {
                let rockets = try await rocketRepository.getAllRockets()
                screenState = .data(rockets: rockets)
            } catch {
                screenState = .error
            }
        }
    }
}

// MARK: - Protocol conformance to RocketViewModel
extension RocketListScreenViewModelImpl: RocketListScreenViewModel {

    func onErrorTap() {
        screenState = .loading
        loadRockets()
    }

    func onAppear() {
        screenState = .loading
        loadRockets()
    }

    func onRocketTap(rocketId: String) {
        selectedRocketId = rocketId
    }

    func onPullToRefresh() async {
        loadRockets()
        try? await Task.sleep(for: .seconds(1))
    }
}
