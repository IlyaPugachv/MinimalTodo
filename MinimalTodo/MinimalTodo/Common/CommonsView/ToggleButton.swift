import UIKit

class ToggleButton: UIButton {
    
    private let pinBlackImageView: UIImageView = .init(image: .pinBlack)
    private let pinWhiteImageView: UIImageView = .init(image: .pinWhite)
    
    private let pinTitle = " Pin"
    private let pinnedTitle = " Pinned"
    
    private let pinColor = UIColor.white
    private let pinnedColor = UIColor.black
    
    private var widthConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        
        self.setTitle(pinTitle, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        self.setTitleColor(.black, for: .normal)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = pinColor
        self.setImage(pinBlackImageView.image, for: .normal)
        self.tintColor = .black
        self.layer.cornerRadius = 5
        self.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        
        widthConstraint = self.widthAnchor.constraint(equalToConstant: 47)
        heightConstraint = self.heightAnchor.constraint(equalToConstant: 25)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
    }
    
    @objc private func toggleButton() {
        let isPinned = self.backgroundColor == pinnedColor
        
        UIView.animate(withDuration: 0.3) {
            self.setTitle(isPinned ? self.pinTitle : self.pinnedTitle, for: .normal)
            self.setTitleColor(isPinned ? .black : .white, for: .normal)
            self.backgroundColor = isPinned ? self.pinColor : self.pinnedColor
            self.setImage(isPinned ? self.pinBlackImageView.image : self.pinWhiteImageView.image, for: .normal)
            
            self.widthConstraint.constant = isPinned ? 47 : 62
            self.heightConstraint.constant = isPinned ? 25 : 24
            
        }
    }
}
