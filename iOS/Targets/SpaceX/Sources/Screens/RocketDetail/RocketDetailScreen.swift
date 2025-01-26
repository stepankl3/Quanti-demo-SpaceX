import SwiftUI
import SpaceXUI
import SpaceXKit
import Kingfisher

struct RocketDetailScreen<ViewModel>: View where ViewModel: RocketDetailScreenViewModel {

    // MARK: - Dependencies
    @StateObject var viewModel: ViewModel

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            switch viewModel.screenState {
            case .loading:
                ScreenLoader()
            case .error:
                errorView
            case .data(let detail):
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        overViewSection(detail: detail)
                        parameterSection(detail: detail)
                        stagesSection(detail: detail)
                        photosSection(photos: detail.imagesUrl)
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle(viewModel.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: Supporting views
extension RocketDetailScreen {

    @ViewBuilder
    func overViewSection(detail: RocketDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(SpaceXStrings.RocketDetailScreen.SectionOverview.title)
                .font(.headline.bold())
                .foregroundStyle(SpaceXColor.primaryText)
            Text(detail.description)
                .font(.subheadline)
                .foregroundStyle(SpaceXColor.primaryText)
        }
    }

    @ViewBuilder
    func parameterSection(detail: RocketDetail) -> some View {
        Text(SpaceXStrings.RocketDetailScreen.SectionParameter.title)
            .font(.headline.bold())
            .foregroundStyle(SpaceXColor.primaryText)
            .padding(.top, 8)
        // TODO: Use geometry reader
        HStack(alignment: .center, spacing: 16) {
            ParameterCard(title: "\(detail.heightMeters.rounded().formatted())\(SpaceXStrings.Common.meters)",
                          subtitle: SpaceXStrings.RocketDetailScreen.SectionParameter.height)
            ParameterCard(title: "\(detail.diameterMeters.rounded().formatted())\(SpaceXStrings.Common.meters)",
                          subtitle: SpaceXStrings.RocketDetailScreen.SectionParameter.diameter)
            ParameterCard(title: "\((detail.massKg / 1000).formatted())\(SpaceXStrings.Common.tons)",
                          subtitle: SpaceXStrings.RocketDetailScreen.SectionParameter.mass)
        }
    }

    @ViewBuilder
    func stagesSection(detail: RocketDetail) -> some View {
        RowsCard(title: SpaceXStrings.RocketDetailScreen.SectionStage.first,
                 rows: getStageRows(stage: detail.firstStage))
        RowsCard(title: SpaceXStrings.RocketDetailScreen.SectionStage.second,
                 rows: getStageRows(stage: detail.secondStage))
    }

    @ViewBuilder
    func photosSection(photos: [URL]) -> some View {
        if !photos.isEmpty {
            Text(SpaceXStrings.RocketDetailScreen.SectionPhotos.title)
                .font(.title2.bold())
            LazyVStack(spacing: 8) {
                ForEach(photos, id: \.self) { photo in
                    KFImage(photo)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }

    @ViewBuilder
    var errorView: some View {
        ErrorPage(text: SpaceXStrings.ListScreen.errorDescription,
                  extraContent: {
            PrimaryButton(title: SpaceXStrings.Common.retry,
                          action: viewModel.onRetryTapped)
        })
    }
}

// MARK: - Util functions
extension RocketDetailScreen {

    func getStageRows(stage: Stage) -> [Row] {

        typealias XString = SpaceXStrings.RocketDetailScreen.SectionStage
        let reusableString = stage.reusable ? XString.reusable : XString.nonreusable

        return [Row(image: SpaceXAsset.reusable, text: reusableString),
                Row(image: SpaceXAsset.engine, text: "\(stage.engines) \(XString.engines)"),
                Row(image: SpaceXAsset.fuel, text: "\(stage.fuelAmountTons.formatted()) \(XString.fuel)"),
                Row(image: SpaceXAsset.burn, text: "\(stage.burnTimeSeconds?.formatted() ?? "??") \(XString.burnTime)")
        ]
    }
}

// MARK: - Preview
struct RocketDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RocketDetailScreen(viewModel: RocketDetailScreenViewModelImpl(rocketId: "12"))
        }
    }
}
