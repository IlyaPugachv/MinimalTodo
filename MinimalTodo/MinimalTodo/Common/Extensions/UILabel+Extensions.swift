import UIKit

extension UILabel {
    static func createLabel(text: String, font: UIFont, textColor: UIColor = .black, alignment: NSTextAlignment = .left, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        return label
    }
}

extension UILabel {
  
    func configureLabel(text: String, font: UIFont, color: UIColor) {
        self.text = text
        self.font = font
        self.textColor = color
    }
}
