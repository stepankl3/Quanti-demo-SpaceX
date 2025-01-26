import SwiftUI
import SpaceXUI
import SpaceXKit

struct RocketListScreen<ViewModel>: View where ViewModel: RocketListScreenViewModel {

    // MARK: - Properties
    @StateObject var viewModel: ViewModel

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            switch viewModel.screenState {
            case .loading:
                ScreenLoader()
            case .error:
                errorView
            case .data(let rockets):
                if rockets.isEmpty {
                    emptyView
                } else {
                    rocketList(rockets: rockets)
                }
            }
        }
        .refreshable {
            viewModel.onPullToRefresh()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .navigationDestination(item: $viewModel.selectedRocketId) { rocketId in
            Screens.rocketDetail(id: rocketId)
        }
        .background(SpaceXColor.elevatedBackground)
        .navigationTitle(SpaceXStrings.ListScreen.title)
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Supporting views
extension RocketListScreen {

    @ViewBuilder
    func rocketList(rockets: [Rocket]) -> some View {
        List {
            ForEach(rockets) { rocket in
                ListCell(image: SpaceXAsset.rocket,
                         title: rocket.name,
                         description: "\(SpaceXStrings.ListScreen.Cell.firstFlight): \(rocket.firstFlight.dateString)")
                .onTapGesture {
                    viewModel.onRocketTap(rocketId: rocket.id)
                }
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    0
                }
            }
            .listRowBackground(SpaceXColor.background)

        }
    }

    @ViewBuilder
    var errorView: some View {
        ErrorPage(text: SpaceXStrings.ListScreen.errorDescription,
                  extraContent: {
            PrimaryButton(title: SpaceXStrings.Common.retry,
                          action: viewModel.onErrorTap)
        })
    }

    @ViewBuilder
    var emptyView: some View {
        ErrorPage(text: SpaceXStrings.ListScreen.emptyDescription,
                  extraContent: { EmptyView() })
    }
}

// MARK: - Previews
#Preview {
    NavigationStack {
        RocketListScreen(viewModel: RocketListScreenViewModelMock(startingState: .data(rockets: [])))
    }
}

#Preview {
    NavigationStack {
        RocketListScreen(viewModel: RocketListScreenViewModelMock(startingState: .error))
    }
}

#Preview {
    NavigationStack {
        RocketListScreen(viewModel: RocketListScreenViewModelMock(startingState: .loading))
    }
}

#Preview {
    NavigationStack {
        RocketListScreen(viewModel: RocketListScreenViewModelImpl())
    }
}
