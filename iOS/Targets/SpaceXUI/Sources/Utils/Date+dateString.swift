import Foundation

public extension Date {

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.M.yyyy"
        return formatter.string(from: self)
    }
}
