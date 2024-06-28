import UIKit

struct TodoList: Codable {
    let id: UUID
    var title: String
    var label: String
    var date: String
    var additionalFields: [String]
    var colorIdentifier: String?
    
    init(title: String, label: String, date: String, additionalFields: [String]) {
        self.id = UUID()
        self.title = title
        self.label = label
        self.date = date
        self.additionalFields = additionalFields
    }
    
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
