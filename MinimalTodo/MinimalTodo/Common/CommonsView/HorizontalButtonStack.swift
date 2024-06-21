import UIKit

class HorizontalButtonStack: UIStackView {
    
    // MARK: - Properties
    
    private let buttonTitles = ["Привет", "Пока", "четыре", "восемь"]
    private var buttons: [UIButton] = []
    private var selectedButton: UIButton?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButtons() {
        for title in buttonTitles {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 8
            button.titleLabel?.font = .interMedium(of: 12)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 62),
                button.heightAnchor.constraint(equalToConstant: 28)
            ])
        }
    }
    
    private func setupStackView() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for button in buttons {
            self.addArrangedSubview(button)
        }
    }
    
    // MARK: - Button Actions
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if let selectedButton = selectedButton {
            selectedButton.backgroundColor = .lightGray
        }
        
        sender.backgroundColor = .black
        selectedButton = sender
    }
}
