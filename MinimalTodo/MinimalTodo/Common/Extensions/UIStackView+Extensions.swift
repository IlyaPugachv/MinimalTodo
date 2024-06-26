import UIKit

extension UIStackView {
    func setupVerticalStackView(spacing: CGFloat = 10, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) {
        self.axis = .vertical
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
    
    func setupHorizontalStackView(spacing: CGFloat = 10, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) {
        self.axis = .horizontal
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
