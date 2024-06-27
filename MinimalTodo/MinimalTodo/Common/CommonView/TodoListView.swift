import UIKit

final class TodoListView: UIView {

    // MARK: - Properties -
    
    private let todoList: TodoList
    
    // MARK: - Subviews -
    
    private let headerLabel = UILabel()
    private let dateLabel = UILabel()
    private let calendarImageView = UIImageView()
    private let blackView: BackgroundView
    private let dateStackView = UIStackView()
    private let labelsStackView = UIStackView()
    private let mainStackView = UIStackView()
    
    // MARK: - Initializers -
    
    init(todoList: TodoList, frame: CGRect = .zero) {
        self.todoList = todoList
        self.blackView = BackgroundView(text: todoList.label)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        buildHierarchy()
        configureSubviews()
        setupLayoutSubviews()
        setupActions()
        
        // Apply random background color from UIColor.Colors
        self.backgroundColor = UIColor.Colors.randomColor()
    }
    
    private func buildHierarchy() {
        addView(mainStackView)
        mainStackView.addArrangedSubview(headerLabel)
        
        for field in todoList.additionalFields {
            let fieldLabel = UILabel()
            
            fieldLabel.configureLabel(
                text: field,
                font: .interSemibold(of: 14),
                color: .black)
            
            mainStackView.addArrangedSubview(fieldLabel)
        }
        
        mainStackView.addArrangedSubview(labelsStackView)
    }
    
    private func configureSubviews() {
        
        headerLabel.configureLabel(
            text: todoList.title,
            font: .interMedium(of: 20),
            color: .black
        )
        
        dateLabel.configureLabel(
            text: todoList.date,
            font: .interSemibold(of: 8),
            color: .black
        )
        
        calendarImageView.setCustomImage(
            named: "calendar")
        
        dateStackView.setupHorizontalStackView(
            spacing: 4,
            alignment: .center
        )
        
        dateStackView.addArrangedSubview(calendarImageView)
        dateStackView.addArrangedSubview(dateLabel)
        
        labelsStackView.setupHorizontalStackView(
            spacing: 10)
        
        labelsStackView.addArrangedSubview(blackView)
        labelsStackView.addArrangedSubview(dateStackView)
        
        mainStackView.setupVerticalStackView(
            spacing: 4,
            alignment: .leading
        )
    }
    
    private func setupLayoutSubviews() {
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    private func setupActions() { }
}

extension UIColor.Colors {
    static func randomColor() -> UIColor {
        let colors: [UIColor] = [
            UIColor.Colors.yellow,
            UIColor.Colors.green,
            UIColor.Colors.violet,
            UIColor.Colors.red
        ]
        return colors.randomElement() ?? .clear
    }
}
