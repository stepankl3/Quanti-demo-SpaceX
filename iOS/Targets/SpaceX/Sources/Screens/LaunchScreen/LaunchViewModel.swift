import Foundation
import CoreMotion
import Combine
import SwiftUI

@MainActor
protocol LaunchScreenViewModel: ObservableObject {

    var isRocketLaunched: Bool { get }
    var shouldShowLaunchButton: Bool { get }
    var rocketOffset: Int { get }
    func launchTapped()
    func onAppear()
}

@MainActor
class LaunchScreenViewModelImpl: ObservableObject {

    // MARK: - Properties
    @Published var isRocketLaunched = false
    @Published var rocketOffset = 0
    @Published var shouldShowLaunchButton = false

    private let launchedOffset = Int(-UIScreen.main.bounds.height * 1.5)

    // MARK: - Dependencies
    private let motionManager = CMMotionManager()

    private func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data else { return }
                let accelerometerData = AccelerometerData(x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z)
                if accelerometerData.isPhoneUpsideDown {
                    self?.isRocketLaunched = true
                    withAnimation {
                        self?.rocketOffset = self?.launchedOffset ?? 0
                    }
                }
            }
        } else {
            shouldShowLaunchButton = true
        }
    }
}

extension LaunchScreenViewModelImpl: LaunchScreenViewModel {

    func launchTapped() {
        isRocketLaunched = true
        withAnimation {
            rocketOffset = launchedOffset
        }
    }

    func onAppear() {
        startAccelerometerUpdates()
        isRocketLaunched = false
    }
}

struct AccelerometerData {
    var x: Double
    var y: Double
    var z: Double

    var isPhoneUpsideDown: Bool {
        return abs(y) > 0.8
    }
}
