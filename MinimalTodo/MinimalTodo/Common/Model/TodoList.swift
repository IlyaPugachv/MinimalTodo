import UIKit

struct TodoList: Codable {
    var title: String
    var label: String
    var date: String
    var additionalFields: [String]
    var colorIdentifier: String?
    
    mutating func assignRandomColor() {
        guard colorIdentifier == nil else { return }
        let colors: [String: UIColor] = [
            "yellow": UIColor.Colors.yellow,
            "green": UIColor.Colors.green,
            "violet": UIColor.Colors.violet,
            "red": UIColor.Colors.red
        ]
        let randomKey = colors.keys.randomElement() ?? "clear"
        colorIdentifier = randomKey
    }
    
    func getColor() -> UIColor {
        let colors: [String: UIColor] = [
            "yellow": UIColor.Colors.yellow,
            "green": UIColor.Colors.green,
            "violet": UIColor.Colors.violet,
            "red": UIColor.Colors.red
        ]
        return colors[colorIdentifier ?? "clear"] ?? .clear
    }
}
