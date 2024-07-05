import UIKit

extension NewList {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        private var todoLists: [TodoList] = []
        
        private var selectedLabel: String?
        private var textFields: [UITextField] = []
        
        // MARK: - Subviews -
        
        private let backButton: UIButton = .init()
        private let toggleButton = ToggleButton()
        
        private let titleTextField: UITextField = .init()
        
        private let addTextFieldButton = UIButton()
        
        private let textFieldStackView: UIStackView = .init()
        private let containerStackView: UIStackView = .init()
        
        private let plusTodoImageView: UIImageView = .init()
        private let addListButton: UIButton = .init()
        private let stackView: UIStackView = .init()
        private let addButtonStack: UIStackView = .init()
        
        private var separatorView: UIView = .init()
        private let chooseLabel: UILabel = .init()
        
        private let personalButton: UIButton = .init()
        private let workButton: UIButton = .init()
        private let financeButton: UIButton = .init()
        private let otherButton: UIButton = .init()
        private let buttonStackView: UIStackView = .init()
        
        // MARK: - Initializers -
        
        public init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
            
            presenter.view = self
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        deinit { }
        
        // MARK: - Lifecycle -
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setup()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        public override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            saveTodoList()
        }
        
        // MARK: - Methods -
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
            setupActions()
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .white
            
            view.addView(toggleButton)
            view.addView(backButton)
            view.addView(titleTextField)
            view.addView(containerStackView)
            view.addView(stackView)
            view.addView(addButtonStack)
            view.addView(chooseLabel)
            view.addView(separatorView)
            view.addView(buttonStackView)
        }
        
        private func configureSubviews() {
            
            backButton.setCustomImage(
                named: "custom_back_arrow",
                for: .normal
            )
            
            configureBackButton()
            configureRightBarButton()
            
            titleTextField.configureTextField(
                placeholder: .Localization.title,
                font: .interSemibold(of: 24),
                returnKeyType: .done,
                delegate: self)
            
            addTextFieldButton.setCustomImage(
                named: "plus",
                for: .normal
            )

            containerStackView.setupVerticalStackView(
                spacing: 10,
                alignment: .fill,
                distribution: .fill
            )
            
            textFieldStackView.setupVerticalStackView(
                spacing: 8,
                alignment: .fill,
                distribution: .fill
            )
            
            stackView.setupVerticalStackView(
                spacing: 8,
                alignment: .fill,
                distribution: .fill
            )
            
            addButtonStack.setupHorizontalStackView(
                spacing: 8,
                distribution: .fill
            )
            
            addButtonStack.addArrangedSubview(plusTodoImageView)
            addButtonStack.addArrangedSubview(addListButton)

            chooseLabel.configureLabel(
                text: .Localization.chooseALabel,
                font: .interMedium(of: 20),
                color: .black
            )
            
            separatorView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            
            [personalButton, workButton, financeButton, otherButton].forEach {
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = .lightGray
                $0.layer.cornerRadius = 6
                $0.addTarget(self, action: #selector(labelButtonTapped(_:)), for: .touchUpInside)
            }

            personalButton.setTitle(
                .Localization.personal,
                for: .normal
            )
            
            workButton.setTitle(
                .Localization.work,
                for: .normal
            )
            
            financeButton.setTitle(
                .Localization.finance,
                for: .normal
            )
            
            otherButton.setTitle(
                .Localization.other,
                for: .normal
            )
         
            buttonStackView.setupHorizontalStackView(
                spacing: 10,
                distribution: .fillEqually
            )
            
            buttonStackView.addArrangedSubview(personalButton)
            buttonStackView.addArrangedSubview(workButton)
            buttonStackView.addArrangedSubview(financeButton)
            buttonStackView.addArrangedSubview(otherButton)
            
            let horizontalStack = UIStackView()
            
            horizontalStack.setupHorizontalStackView(
                spacing: 0,
                alignment: .fill,
                distribution: .fill
            )
            
            horizontalStack.addArrangedSubview(addTextFieldButton)
  
            let spacerView = UIView()
            horizontalStack.addArrangedSubview(spacerView)
            
            containerStackView.addArrangedSubview(textFieldStackView)
            containerStackView.addArrangedSubview(horizontalStack)
            
           
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                toggleButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
                toggleButton.trailingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: -20),
                
                backButton.topAnchor.constraint(equalTo: toggleButton.topAnchor),
                backButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
                
                titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
                titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                
                containerStackView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
                containerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
                containerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
  
                textFieldStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 10),
                textFieldStackView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor, constant: -10),
                
                stackView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                
                addButtonStack.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
                addButtonStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                addButtonStack.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -20),
                addButtonStack.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -20),
                
                plusTodoImageView.widthAnchor.constraint(equalToConstant: 20),
                plusTodoImageView.heightAnchor.constraint(equalToConstant: 20),
                
                separatorView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -150),
                separatorView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                separatorView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                separatorView.heightAnchor.constraint(equalToConstant: 1),
                
                chooseLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
                chooseLabel.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor),
                
                buttonStackView.topAnchor.constraint(equalTo: chooseLabel.bottomAnchor, constant: 20),
                buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                buttonStackView.heightAnchor.constraint(equalToConstant: 28),
            ])
        }
        
        private func configureBackButton() {
            
            let backButtonItem = UIBarButtonItem(customView: backButton)
            
            navigationItem.leftBarButtonItem = backButtonItem
            
            navigationItem.backBarButtonItem = UIBarButtonItem(
                title: "",
                style: .plain,
                target: nil,
                action: nil)
        }
        
        private func configureRightBarButton() {
            let toggleButtonItem = UIBarButtonItem(customView: toggleButton)
            navigationItem.rightBarButtonItem = toggleButtonItem
        }
        
        private func setupActions() {
            
            addTextFieldButton.addTarget(self,
                                         action: #selector(addTextFieldButtonTapped),
                                         for: .touchUpInside)
            
            backButton.addAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.presenter.back()
            }), for: .touchUpInside)
        }
        
        private func saveTodoList() {
            let title = titleTextField.text ?? ""
            let label = selectedLabel ?? .Localization.personal
            let date = DateFormatter.formattedDate()
            let additionalFields = textFields.map { $0.text ?? "" }
            let isPinned = toggleButton.backgroundColor == .black

            let newList = TodoList(title: title, label: label, date: date, additionalFields: additionalFields, isPinned: isPinned)
            todoLists.append(newList)

            saveTodoListToUserDefaults()
            presenter.updateMainView(with: newList)
        }

        private func saveTodoListToUserDefaults() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(todoLists) {
                UserDefaults.standard.set(encoded, forKey: "TodoLists")
            }
        }
        
        // MARK: - OBJC FUNC -
        
        @objc
        private func labelButtonTapped(_ sender: UIButton) {
            [personalButton, workButton, financeButton, otherButton].forEach {
                $0.backgroundColor = .lightGray
            }
            sender.backgroundColor = .black
            selectedLabel = sender.title(for: .normal)
        }
        
        @objc
        private func addTextFieldButtonTapped() {
            let newTextFieldView = createTextFieldView()
            textFieldStackView.addArrangedSubview(newTextFieldView)
        }
        
        private func createTextFieldView() -> UIView {
            let view = UIView()
           
            let checkbox = UIButton()
            checkbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            checkbox.setImage(UIImage(systemName: "square"), for: .normal)
            checkbox.tintColor = .black
            checkbox.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
           
            let textField = UITextField()
            textField.font = .interRegularLight(of: 14)
            textField.returnKeyType = .done
            textField.delegate = self
            
            textFields.append(textField)
            
            view.addView(checkbox)
            view.addView(textField)
            
            NSLayoutConstraint.activate([
                checkbox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -2),
                checkbox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                checkbox.widthAnchor.constraint(equalToConstant: 24),
                checkbox.heightAnchor.constraint(equalToConstant: 24),
                
                textField.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 8),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                textField.topAnchor.constraint(equalTo: view.topAnchor),
                textField.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            
            return view
        }
        
        @objc
        private func checkboxTapped(_ sender: UIButton) {
            sender.isSelected.toggle()
        }
    }
}

extension NewList.View: NewListView, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

