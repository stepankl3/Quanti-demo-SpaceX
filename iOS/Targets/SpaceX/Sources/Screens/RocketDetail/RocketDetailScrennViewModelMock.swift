import Foundation

@MainActor
public class RocketDetailScreenViewModelMock: RocketDetailScreenViewModel {

    // MARK: - Properties
    @Published var screenState: RocketDetailScreenState
    @Published var screenTitle: String = ""
    @Published var destination: RocketDetailScreenDestinations?

    // MARK: - Init
    init(screenState: RocketDetailScreenState) {
        self.screenState = screenState
    }

    func onAppear() {}
    
    func onLaunchTapped() {}
    
    func onRetryTapped() {}
}
