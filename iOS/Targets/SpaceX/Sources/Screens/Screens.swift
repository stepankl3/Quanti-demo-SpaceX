import Factory
import Foundation

@MainActor
enum Screens {

    static var rocketList: RocketListScreen<RocketListScreenViewModelImpl> {
        let viewModel = RocketListScreenViewModelImpl()
        return RocketListScreen(viewModel: viewModel)
    }

    static func rocketDetail(id: String) -> RocketDetailScreen<RocketDetailScreenViewModelImpl> {
        let viewModel = RocketDetailScreenViewModelImpl(rocketId: id)
        return RocketDetailScreen(viewModel: viewModel)
    }

    static var launchScreen: LaunchScreen<LaunchScreenViewModelImpl> {
        let viewModel = LaunchScreenViewModelImpl()
        return LaunchScreen(viewModel: viewModel)
    }
}
