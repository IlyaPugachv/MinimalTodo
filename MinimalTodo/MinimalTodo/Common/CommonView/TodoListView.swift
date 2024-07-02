import UIKit

protocol TodoListViewDelegate: AnyObject {
    func todoListViewDidSwipeToDelete(_ todoListView: TodoListView)
}

final class TodoListView: UIView {
    
    // MARK: - Properties -
    
    let todoList: TodoList
    weak var delegate: TodoListViewDelegate?
    
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
    
    // MARK: - Methods -
    
    private func setup() {
        buildHierarchy()
        configureSubviews()
        setupLayoutSubviews()
        addSwipeGesture()
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        self.backgroundColor = todoList.getColor()
    }
    
    private func addSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .left
        self.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        guard gesture.state == .ended else { return }
        delegate?.todoListViewDidSwipeToDelete(self)
    }
    
    private func buildHierarchy() {
        addView(mainStackView)
        mainStackView.addArrangedSubview(headerLabel)
        
        for field in todoList.additionalFields {
            let fieldStackView = UIStackView()
            fieldStackView.axis = .horizontal
            fieldStackView.alignment = .center
            fieldStackView.spacing = 8
            
            let checkbox = UIButton()
            checkbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.tintColor = .black
            checkbox.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
            
            let fieldLabel = UILabel()
            fieldLabel.configureLabel(
                text: field,
                font: .interRegularLight(of: 14),
                color: .black
            )
            fieldLabel.tag = 100 // Set a tag to identify this label later
            
            fieldStackView.addArrangedSubview(checkbox)
            fieldStackView.addArrangedSubview(fieldLabel)
            
            mainStackView.addArrangedSubview(fieldStackView)
        }
        
        mainStackView.addArrangedSubview(labelsStackView)
    }
    
    private func configureSubviews() {
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
        headerLabel.configureLabel(
            text: todoList.title,
            font: .interMedium(of: 20),
            color: .black
        )
        
        dateLabel.configureLabel(
            text: todoList.date,
            font: .interRegularLight(of: 8),
            color: .black
        )
        
        calendarImageView.setCustomImage(named: "calendar")
        
        dateStackView.setupHorizontalStackView(
            spacing: 4,
            alignment: .center
        )
        
        dateStackView.addArrangedSubview(calendarImageView)
        dateStackView.addArrangedSubview(dateLabel)
        
        labelsStackView.setupHorizontalStackView(spacing: 10)
        labelsStackView.addArrangedSubview(blackView)
        labelsStackView.addArrangedSubview(dateStackView)
        
        mainStackView.setupVerticalStackView(spacing: 4, alignment: .leading)
    }
    
    private func setupLayoutSubviews() {
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            mainStackView.widthAnchor.constraint(equalToConstant: 327)
        ])
    }
    
    // MARK: - Animation -
    
    func animateDeletion(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = -self.frame.size.width
            self.alpha = 0
        }, completion: { _ in
            completion()
        })
    }
    
    @objc
    private func checkboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if let fieldStackView = sender.superview as? UIStackView,
           let fieldLabel = fieldStackView.arrangedSubviews.first(where: { $0 is UILabel && $0.tag == 100 }) as? UILabel {
            if sender.isSelected {
                let attributedString = NSMutableAttributedString(string: fieldLabel.text ?? "")
                attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
                fieldLabel.attributedText = attributedString
            } else {
                let attributedString = NSMutableAttributedString(string: fieldLabel.text ?? "")
                attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
                fieldLabel.attributedText = attributedString
            }
        }
    }
}
