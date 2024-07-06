import UIKit

extension Main {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        private var todoLists: [TodoList] = []
        private var filteredTodoLists: [TodoList] = []
        
        // MARK: - Subviews -
        
        private let appMiniIconImageView: UIImageView = .init(image: .applicationMiniIcon)
        private let nameAppLabel: UILabel = .init()
        private let searchImageView: UIImageView = .init()
        private let segmentedControl: CustomSegmentedControl = .init()
        private let imageAllListView: UIImageView = .init(image: .imageApp)
        private let imagePinnedView: UIImageView = .init(image: .imageAppOne)
        private let createTodoLabel: UILabel = .init()
        private let noPinnedLabel: UILabel = .init()
        private let newListButton: UIButton = .init()
        
        private let fullScreenView: UIView = .init()
        private let searchTextField: UITextField = .init()
        private let cancelButton: UIButton = .init()

        private let scrollView: UIScrollView = .init()
        private let contentView: UIView = .init()

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
            loadTodoListsFromUserDefaults()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            updateUI()
        }
        
        // MARK: - Methods -
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
            setupActions()
            searchTextField.delegate = self
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .white
            view.addView(appMiniIconImageView)
            view.addView(nameAppLabel)
            view.addView(searchImageView)
            view.addView(segmentedControl)
            view.addView(imageAllListView)
            view.addView(imagePinnedView)
            view.addView(createTodoLabel)
            view.addView(noPinnedLabel)
            view.addView(newListButton)
            view.addView(fullScreenView)
            view.addView(scrollView)
            
            scrollView.addView(contentView)
            
            fullScreenView.addView(searchTextField)
            fullScreenView.addView(cancelButton)
        }
        
        private func configureSubviews() {
            navigationItem.hidesBackButton = true
            
            segmentedControl.delegate = self
            
            fullScreenView.isHidden = true
            fullScreenView.backgroundColor = .white
            
            searchTextField.placeholder = "Search your list"
            searchTextField.backgroundColor = .white
            searchTextField.borderStyle = .roundedRect

            searchTextField.configureTextField(
                placeholder: "Search your list",
                icon: UIImage(systemName: "magnifyingglass"),
                iconColor: .black,
                backgroundColor: .Colors.lightGray

            )
            
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.setTitleColor(.black, for: .normal)
            cancelButton.titleLabel?.font = .interMedium(of: 18)
            cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
            
            appMiniIconImageView.contentMode = .scaleAspectFit
            
            nameAppLabel.configureLabel(
                text: "MinimalTodo",
                font: .interSemibold(of: 20),
                color: .black
            )
            
            searchImageView.image = UIImage(systemName: "magnifyingglass")
            searchImageView.tintColor = .black
            
            createTodoLabel.configureLabel(
                text: .Localization.createYourFirstTodoList,
                font: .interSemibold(of: 20),
                color: .black
            )
            
            noPinnedLabel.configureLabel(
                text: .Localization.ooopsNoPinnedListYet,
                font: .interSemibold(of: 20),
                color: .black
            )
            
            newListButton.backgroundColor = .black
            newListButton.layer.cornerRadius = 32.5
            
            newListButton.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
            newListButton.tintColor = .white
            
            searchTextField.addClearButton()
            hideKeyboardWhenTappedAround()
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                appMiniIconImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                appMiniIconImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                appMiniIconImageView.widthAnchor.constraint(equalToConstant: 31),
                appMiniIconImageView.heightAnchor.constraint(equalToConstant: 26),
                
                nameAppLabel.topAnchor.constraint(equalTo: appMiniIconImageView.topAnchor),
                nameAppLabel.leadingAnchor.constraint(equalTo: appMiniIconImageView.trailingAnchor, constant: 10),
                
                searchImageView.topAnchor.constraint(equalTo: appMiniIconImageView.topAnchor),
                searchImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
                searchImageView.widthAnchor.constraint(equalToConstant: 24),
                searchImageView.heightAnchor.constraint(equalToConstant: 24),
                
                segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 65),
                segmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                segmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                segmentedControl.heightAnchor.constraint(equalToConstant: 47),
                
                scrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
                scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: newListButton.topAnchor, constant: -20),
                
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                imageAllListView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
                imageAllListView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                imagePinnedView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
                imagePinnedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                createTodoLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -160),
                createTodoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                noPinnedLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -160),
                noPinnedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                newListButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                newListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                newListButton.widthAnchor.constraint(equalToConstant: 65),
                newListButton.heightAnchor.constraint(equalToConstant: 65),
                
                fullScreenView.topAnchor.constraint(equalTo: view.topAnchor),
                fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                fullScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                fullScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                searchTextField.topAnchor.constraint(equalTo: fullScreenView.topAnchor, constant: 130),
                searchTextField.leadingAnchor.constraint(equalTo: fullScreenView.leadingAnchor, constant: 20),
                searchTextField.widthAnchor.constraint(equalToConstant: 255),
                searchTextField.heightAnchor.constraint(equalToConstant: 43),
                
                cancelButton.topAnchor.constraint(equalTo: searchTextField.topAnchor),
                cancelButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 20),
                cancelButton.widthAnchor.constraint(equalToConstant: 80),
                cancelButton.heightAnchor.constraint(equalToConstant: 40),
            ])
        }
        
        private func setupActions() {
            newListButton.addAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.presenter.goToNewListScreen()
            }), for: .touchUpInside)
            
            searchImageView.isUserInteractionEnabled = true
            searchImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchImageViewTapped)))
        }
        
        
        private func updateUI() {
            contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let listsToDisplay: [TodoList]
            if fullScreenView.isHidden {
                listsToDisplay = filterTodoLists()
            } else {
                listsToDisplay = searchTodoLists(searchTextField.text)
            }
            
            if listsToDisplay.isEmpty {
                if segmentedControl.selectedSegmentIndex == 0 {
                    imageAllListView.isHidden = false
                    imagePinnedView.isHidden = true
                    createTodoLabel.isHidden = false
                    noPinnedLabel.isHidden = true
                } else if segmentedControl.selectedSegmentIndex == 1 {
                    imageAllListView.isHidden = true
                    imagePinnedView.isHidden = false
                    createTodoLabel.isHidden = true
                    noPinnedLabel.isHidden = false
                }
            } else {
                imageAllListView.isHidden = true
                imagePinnedView.isHidden = true
                createTodoLabel.isHidden = true
                noPinnedLabel.isHidden = true
                
                var previousView: UIView? = nil
                for todoList in listsToDisplay {
                    let todoListView = TodoListView(todoList: todoList)
                    todoListView.delegate = self
                    contentView.addView(todoListView)
                    
                    NSLayoutConstraint.activate([
                        todoListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                        todoListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                        todoListView.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? contentView.topAnchor, constant: previousView == nil ? 0 : 20),
                    ])
                    
                    previousView = todoListView
                }
                
                if let previousView = previousView {
                    previousView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
                }
            }
        }
        
        private func filterTodoLists() -> [TodoList] {
            let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
            switch selectedSegmentIndex {
            case 0:
                return todoLists.filter { !$0.isPinned }
            case 1:
                return todoLists.filter { $0.isPinned }
            default:
                return todoLists.filter { !$0.isPinned }
            }
        }
        
        private func searchTodoLists(_ query: String?) -> [TodoList] {
            guard let query = query, !query.isEmpty else { return todoLists }
            return todoLists.filter { $0.title.localizedCaseInsensitiveContains(query) }
        }
        
        private func loadTodoListsFromUserDefaults() {
            if let savedData = UserDefaults.standard.data(forKey: "TodoLists") {
                let decoder = JSONDecoder()
                if let loadedLists = try? decoder.decode([TodoList].self, from: savedData) {
                    todoLists = loadedLists
                }
            }
        }
        
        public func addTodoList(_ todoList: TodoList) {
            var newTodoList = todoList
            newTodoList.assignRandomColor()
            
            todoLists.append(newTodoList)
            saveTodoListsToUserDefaults()
            updateUI()
        }

        private func saveTodoListsToUserDefaults() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(todoLists) {
                UserDefaults.standard.set(encoded, forKey: "TodoLists")
            }
        }
        
        @objc
        private func searchImageViewTapped() {
 
            fullScreenView.isHidden = false
            fullScreenView.alpha = 0
            
            UIView.animate(withDuration: 0.2, animations: {
                self.fullScreenView.alpha = 1
                self.contentView.subviews.forEach { $0.alpha = 0 }
            }) { _ in
                self.contentView.subviews.forEach { $0.isHidden = true }
            }
            
            searchTextField.becomeFirstResponder()
        }
        
        @objc
        private func cancelButtonTapped() {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.fullScreenView.alpha = 0
                self.contentView.subviews.forEach { $0.alpha = 1; $0.isHidden = false }
            }) { _ in
                self.fullScreenView.isHidden = true
                self.searchTextField.text = ""
                self.fullScreenView.alpha = 1
                self.updateUI()
            }
        }
    }
}

extension Main.View: MainView, TodoListViewDelegate {
    func todoListViewDidSwipeToDelete(_ todoListView: TodoListView) {
        
        showAlertWithConfirmation(
            title: "Удаление",
            message: "Вы уверены, что хотите удалить этот элемент?",
            yesButtonTitle: "Да",
            noButtonTitle: "Нет",
            yesCompletion: {

                guard let index = self.todoLists.firstIndex(where: { $0.id == todoListView.todoList.id }) else { return }
                todoListView.animateDeletion {
                    self.todoLists.remove(at: index)
                    self.saveTodoListsToUserDefaults()
                    self.updateUI()
                }
            },
            noCompletion: { }
        )
    }
}

extension Main.View: CustomSegmentedControlDelegate {
    func segmentedControlChanged(to index: Int) {
        updateUI()
    }
}

extension Main.View: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateUI()
        return true
    }
}

