import Foundation

struct TodoList: Codable {
    var title: String
    var label: String
    var date: String
    var additionalFields: [String]
}
