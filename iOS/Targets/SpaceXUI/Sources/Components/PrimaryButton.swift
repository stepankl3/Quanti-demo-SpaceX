import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(.opaqueText))
                .padding()
                .frame(minWidth: 100, maxWidth: 200, idealHeight: 32)
                .background(Color(.primary))
                .cornerRadius(12)
        }
    }
}

#Preview {
    PrimaryButton(title: "Click me") {
        print("Button clicked")
    }
}
