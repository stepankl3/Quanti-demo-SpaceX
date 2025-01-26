import SwiftUI
import SpaceXKit

public struct RocketDetailScreen<ViewModel>: View where ViewModel: RocketDetailScreenViewModel {
    // MARK: - Dependencies
    @StateObject var viewModel: ViewModel

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            switch viewModel.screenState {
            case .loading:
                ProgressView()
            case .error:
                VStack {
                    Text("An error occurred. Tap to retry.")
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.onAppear()
                        }
                }
            case .data(let detail):
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(detail.name)
                            .font(.largeTitle.bold())

                        Text("Overview")
                            .font(.title2.bold())
                        Text(detail.description)
                            .foregroundColor(.gray)

                        Text("Parameters")
                            .font(.title2.bold())
                        HStack {
                            ParameterView(title: "\(detail.heightMeters)", subtitle: "height")
                            ParameterView(title: "\(detail.diameterMeters)", subtitle: "diameter")
                            ParameterView(title: "\(detail.massKg)", subtitle: "mass")
                        }

                        StageView(title: "First Stage", stage: detail.firstStage)
                        StageView(title: "Second Stage", stage: detail.secondStage)

                        Text("Photos")
                            .font(.title2.bold())
                        if let image = detail.imagesUrl.first {
                            // TODO: Load images
//                            Image(image)
//                                .resizable()
//                                .scaledToFit()
//                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Supporting Views
struct ParameterView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title.bold())
                .foregroundColor(.white)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(width: 100, height: 80)
        .background(Color.pink)
        .cornerRadius(10)
    }
}

struct StageView: View {
    let title: String
    let stage: Stage

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline.bold())

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: stage.reusable ? "arrow.clockwise" : "xmark")
                    Text(stage.reusable ? "reusable" : "not reusable")
                }
                HStack {
                    Image(systemName: "flame")
                    Text("\(stage.engines) engines")
                }
                HStack {
                    Image(systemName: "fuelpump")
                    Text("\(stage.fuelAmountTons) of fuel")
                }
                if let burnTime = stage.burnTimeSeconds {
                    HStack {
                        Image(systemName: "clock")
                        Text("\(burnTime) burn time")
                    }
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
        }
    }
}

// MARK: - Preview
struct RocketDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        RocketDetailScreen(viewModel: RocketDetailScreenViewModelImpl(rocketId: "12"))
    }
}
