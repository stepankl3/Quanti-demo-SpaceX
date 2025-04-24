import Foundation
import SpaceXKit
import Factory

@MainActor
protocol RocketDetailScreenViewModel: ObservableObject {

    var screenState: RocketDetailScreenState { get }
    var screenTitle: String { get }
    var destination: RocketDetailScreenDestinations? { get set }

    func onAppear()
    func onLaunchTapped()
    func onRetryTapped()
}

// MARK: - Screen State Enum
enum RocketDetailScreenState {
    case loading
    case error
    case data(detail: RocketDetail)
}

enum RocketDetailScreenDestinations {
    case launch
}

// MARK: - ViewModel Implementation
@MainActor
public class RocketDetailScreenViewModelImpl {

    // MARK: - Dependencies
    @Injected(\RepositoriesContainer.rocketRepository) var repository: RocketRepository
    private let rocketId: String

    // MARK: - Properties
    @Published var screenState: RocketDetailScreenState = .loading
    @Published var screenTitle: String = ""
    @Published var destination: RocketDetailScreenDestinations?

    // MARK: - Init
    init(rocketId: String) {
        self.rocketId = rocketId
    }

    func loadRocketDetail() {
        Task { [repository] in
            do {
                screenState = .loading
                let rocketDetail = try await repository.getRocket(id: rocketId)
                screenTitle = rocketDetail.name
                screenState = .data(detail: rocketDetail)
            } catch {
                screenState = .error
            }
        }
    }
}

// MARK: - Protocol Conformance
extension RocketDetailScreenViewModelImpl: RocketDetailScreenViewModel {

    func onLaunchTapped() {
        destination = .launch
    }
    
    func onAppear() {
        loadRocketDetail()
    }

    func onRetryTapped() {
        loadRocketDetail()
    }
}
