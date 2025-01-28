import SwiftUI

public struct Row: Identifiable {

    public let id = UUID()
    public let image: Image
    public let text: String

    public init(image: Image, text: String) {
        self.image = image
        self.text = text
    }
}

public struct RowsCard: View {

    // MARK: - Properties
    public let title: String
    public let rows: [Row]

    // MARK: - Init
    public init(title: String, rows: [Row]) {
        self.title = title
        self.rows = rows
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title3.bold())
            ForEach(rows) { row in
                HStack(spacing: 12) {
                    row.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 24)
                    Text(row.text)
                        .font(.body)
                        .foregroundStyle(SpaceXColor.primaryText)
                    Spacer()
                }
            }
        }
        .padding()
        .background(SpaceXColor.elevatedBackground)
        .cornerRadius(16)
    }
}
