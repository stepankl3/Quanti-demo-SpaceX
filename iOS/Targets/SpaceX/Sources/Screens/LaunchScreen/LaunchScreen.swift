import SwiftUI
import SpaceXUI
import CoreMotion

struct LaunchScreen<ViewModel>: View where ViewModel: LaunchScreenViewModel {

    // MARK: - Dependencies
    @StateObject var viewModel: ViewModel
    @State private var isPhoneUpsideDown = false
    @State private var rocketPosition: CGFloat = 0

    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.isRocketLaunched ? SpaceXStrings.LaunchScreen.launched : SpaceXStrings.LaunchScreen.ready)
                .font(.subheadline)
                .foregroundStyle(SpaceXColor.primaryText)
                .padding(.vertical, 64)
                .padding(.bottom, 120)
            if viewModel.shouldShowLaunchButton {
                PrimaryButton(title: SpaceXStrings.LaunchScreen.launchButton) {
                    viewModel.launchTapped()
                }
            }
        }
        .overlay {
            rocketImage
                .scaledToFit()
                .frame(width: 100)
                .offset(y: CGFloat(viewModel.rocketOffset))
                .animation(.linear(duration: 4), value: viewModel.rocketOffset)
        }
        .onAppear {
            viewModel.onAppear()
        }
        .navigationTitle(SpaceXStrings.LaunchScreen.title)
    }

    @ViewBuilder
    var rocketImage: some View {
        if viewModel.isRocketLaunched {
            SpaceXAsset.flyingRocket
                .resizable()
        } else {
            SpaceXAsset.idleRocket
                .resizable()
        }
    }
}

#Preview {
    LaunchScreen(viewModel: LaunchScreenViewModelImpl())
}
