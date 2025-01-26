import Foundation
import SpaceXKit

@MainActor
class RocketListScreenViewModelMock: ObservableObject {

    // MARK: - Properties
    @Published var screenState: RocketListScreenState = .loading
    @Published var selectedRocketId: String?

    init(startingState: RocketListScreenState = .loading) {
        self.screenState = startingState
    }
}

// MARK: - Protocol conformance to RocketViewModel
extension RocketListScreenViewModelMock: RocketListScreenViewModel {

    func onErrorTap() {}

    func onAppear() {}

    func onRocketTap(rocketId: String) {
        print("On rocket tap \(rocketId)")
    }

    func onPullToRefresh() {
        print("Pull to refresh")
    }
}
