import Factory
import Foundation

@MainActor
enum Screens {

    static var rocketList: RocketListScreen<RocketListScreenViewModelImpl> {
        let viewModel = RocketListScreenViewModelImpl()
        return RocketListScreen(viewModel: viewModel)
    }

    static var rocketDetail: RocketDetailScreen<RocketDetailScreenViewModelImpl> {
        let viewModel = RocketDetailScreenViewModelImpl()
        return RocketDetailScreen(viewModel: viewModel)
    }
}
