import UIKit

extension UIView {
    func addView(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImageView {
    static func createImageView(systemName: String, tintColor: UIColor = .gray, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.tintColor = tintColor
        imageView.contentMode = contentMode
        return imageView
    }
}

extension UIImageView {
    func setCustomImage(named imageName: String) {
        self.image = UIImage(named: imageName)
    }
}

extension UIStackView {
    static func createStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        return stackView
    }
}
