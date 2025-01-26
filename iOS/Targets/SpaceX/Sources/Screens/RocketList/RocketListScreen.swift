import SwiftUI

struct RocketListScreen<ViewModel>: View where ViewModel: RocketListScreenViewModel {

    // MARK: - Properties
    @ObservedObject var viewModel: ViewModel

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Rockets")
                .font(.largeTitle.bold())
                .padding(.horizontal)

            switch viewModel.screenState {
            case .loading:
                ProgressView()
            case .error:
                VStack {
                    Text("An error occurred. Tap to retry.")
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.onErrorTap()
                        }
                }
            case .data(let rockets):
                if rockets.isEmpty {
                    Text("No rockets available.")
                        .foregroundColor(.gray)
                } else {
                    List(rockets) { rocket in
                        HStack {
                            Image(systemName: "rocket.fill")
                                .foregroundColor(.pink)
                            VStack(alignment: .leading) {
                                Text(rocket.name)
                                    .font(.headline)
                                Text("First flight: \(formattedDate(rocket.firstFlight))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            viewModel.onRocketTap(rocketId: rocket.id)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .navigationDestination(item: $viewModel.selectedRocketId) { rocketId in
            print("RocketId")
            return RocketDetailScreen(viewModel: RocketDetailScreenViewModelImpl())
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// MARK: - Preview
struct RocketsView_Previews: PreviewProvider {
    static var previews: some View {
        RocketListScreen(viewModel: RocketListScreenViewModelImpl())
    }
}
