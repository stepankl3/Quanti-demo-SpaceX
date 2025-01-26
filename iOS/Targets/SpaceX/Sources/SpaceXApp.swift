import SwiftUI
import SpaceXUI

@main
struct SpaceXApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Screens.rocketList
            }
        }
    }
}
