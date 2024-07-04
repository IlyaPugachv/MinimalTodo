import UIKit

class BackgroundView: UIView {
    init(text: String) {
        super.init(frame: .zero)
        
        backgroundColor = .black
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        let label = UILabel.createLabel(text: text, font: UIFont.systemFont(ofSize: 7), textColor: .white, alignment: .center, numberOfLines: 0)
        
        addView(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
