import SwiftUI

public struct ListCell: View {

    // MARK: Properties
    let image: Image
    let title: String
    let description: String

    // MARK: - Init
    public init(image: Image, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }

    // MARK: - Body
    public var body: some View {
        HStack(spacing: 8) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.pink)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.vertical, 8)
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(.primaryText))
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(Color(.secondaryText))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(.secondaryText))
                .frame(width: 18, height: 18)
        }
        .padding(8)
    }
}


// MARK: - Preview
#Preview {
    List {
        ListCell(image: Image(.rocket),
                 title: "Falcon 9",
                 description: "First fligh 24.3.2006")
        ListCell(image: Image(.rocket),
                 title: "Falcon 9",
                 description: "First fligh 24.3.2006")
        ListCell(image: Image(.rocket),
                 title: "Falcon 9",
                 description: "First fligh 24.3.2006")
    }
}


