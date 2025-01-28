import SwiftUI

public struct ErrorPage<ContentView: View>: View {

    let text: String
    @ViewBuilder let extraContent: ContentView

    // MARK: - Init
    public init(text: String, @ViewBuilder extraContent: () -> ContentView = { EmptyView() }) {
        self.text = text
        self.extraContent = extraContent()
    }

    // MARK: - Body
    public var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack {
                Spacer()
                SpaceXAsset.rocketError
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 280)
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .center) {
            VStack {
                Text(text)
                    .font(.title3)
                    .foregroundStyle(SpaceXColor.primaryText)
                    .padding(.bottom, 64)
                extraContent
            }
        }
    }
}

// MARK: - Preview
#Preview {
        ErrorPage(text: "Short text") {
            EmptyView()
        }
}
