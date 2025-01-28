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
        VStack(spacing: 24) {
            Spacer()
            rocketImage
                .scaledToFit()
                .frame(width: 128)
                .offset(y: CGFloat(viewModel.rocketOffset))
                .animation(.linear(duration: 4), value: viewModel.rocketOffset)
            Text(viewModel.isRocketLaunched ? SpaceXStrings.LaunchScreen.launched : SpaceXStrings.LaunchScreen.ready)
                .font(.title3)
                .foregroundStyle(SpaceXColor.primaryText)
                .padding(.horizontal, 96)
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)
            if viewModel.shouldShowLaunchButton {
                PrimaryButton(title: SpaceXStrings.LaunchScreen.launchButton) {
                    viewModel.launchTapped()
                }
            }
        }
        .padding(.bottom, 32)
        .overlay {

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
