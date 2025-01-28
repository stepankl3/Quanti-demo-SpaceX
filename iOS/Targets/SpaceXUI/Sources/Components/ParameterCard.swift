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
        .frame(maxWidth: 200, maxHeight: 200)
        .padding(8)
        .background(SpaceXColor.primary)
        .cornerRadius(12)

    }
}

#Preview {
    ParameterCard(title: "9m", subtitle: "diameter")
    ParameterCard(title: "9m", subtitle: "diameter and other fancy info")
    ParameterCard(title: "1 300 t", subtitle: "diameter")
    ParameterCard(title: "1300t", subtitle: "diameter")
        .frame(width: 100, height: 100)
    ParameterCard(title: "118m", subtitle: "diameter")
        .frame(width: 200, height: 200)
}
