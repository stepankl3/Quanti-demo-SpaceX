import SwiftUI

public struct ParameterCard: View {

    // MARK: - Properties
    let title: String
    let subtitle: String

    // MARK: - Init
    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.title.bold())
                .foregroundColor(SpaceXColor.opaqueText)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(SpaceXColor.opaqueText)
        }
        .padding(16)
        .frame(width: 100, height: 100)
        .background(SpaceXColor.primary)
        .cornerRadius(12)
    }
}
