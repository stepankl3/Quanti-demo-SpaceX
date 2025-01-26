import SwiftUI

public struct ScreenLoader: View {

    // MARK: - Init
    public init() {}

    // MARK: - Body
    public var body: some View {
        ProgressView()
            .controlSize(.extraLarge)
    }
}
