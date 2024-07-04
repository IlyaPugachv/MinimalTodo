//import UIKit
//
//extension Main {
//    class View: UIViewController {
//        
//        // MARK: - Properties -
//        
//        var presenter: Presenter!
//        private lazy var safeArea = self.view.safeAreaLayoutGuide
//        private var todoLists: [TodoList] = []
//        private var filteredTodoLists: [TodoList] = []
//        
//        // MARK: - Subviews -
//        
//        private let appMiniIconImageView: UIImageView = .init(image: .applicationMiniIcon)
//        private let nameAppLabel: UILabel = .init()
//        private let searchImageView: UIImageView = .init()
//        private let segmentedControl: CustomSegmentedControl = .init()
//        private let appImage: UIImageView = .init(image: .imageApp)
//        private let appImageOne: UIImageView = .init(image: .imageAppOne)
//        private let createTodoLabel: UILabel = .init()
//        private let noPinnedLabel: UILabel = .init()
//        private let newListButton: UIButton = .init()
//        
//        private let fullScreenView: UIView = .init()
//        private let searchTextField: UITextField = .init()
//        private let cancelButton: UIButton = .init()
//        
//        // MARK: - Initializers -
//        
//        public init(with presenter: Presenter) {
//            self.presenter = presenter
//            super.init(nibName: nil, bundle: nil)
//            presenter.view = self
//        }
//        
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//        
//        deinit { }
//        
//        // MARK: - Lifecycle -
//        
//        public override func viewDidLoad() {
//            super.viewDidLoad()
//            setup()
//            loadTodoListsFromUserDefaults()
//        }
//        
//        public override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            updateUI()
//        }
//        
//        // MARK: - Methods -
//        
//        private func setup() {
//            buildHierarchy()
//            configureSubviews()
//            layoutSubviews()
//            setupActions()
//            searchTextField.delegate = self
//        }
//        
//        private func buildHierarchy() {
//            view.backgroundColor = .white
//            view.addView(appMiniIconImageView)
//            view.addView(nameAppLabel)
//            view.addView(searchImageView)
//            view.addView(segmentedControl)
//            view.addView(appImage)
//            view.addView(appImageOne)
//            view.addView(createTodoLabel)
//            view.addView(noPinnedLabel)
//            view.addView(newListButton)
//            view.addView(fullScreenView)
//            
//            fullScreenView.addView(searchTextField)
//            fullScreenView.addView(cancelButton)
//        }
//        
//        private func configureSubviews() {
//            navigationItem.hidesBackButton = true
//            
//            fullScreenView.isHidden = true
//            fullScreenView.backgroundColor = .white
//            
//            searchTextField.placeholder = "Search"
//            searchTextField.backgroundColor = .white
//            searchTextField.borderStyle = .roundedRect
//            
//            cancelButton.setTitle("Cancel", for: .normal)
//            cancelButton.setTitleColor(.black, for: .normal)
//            cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
//            
//            segmentedControl.delegate = self
//            
//            appMiniIconImageView.contentMode = .scaleAspectFit
//            
//            nameAppLabel.configureLabel(
//                text: "MinimalTodo",
//                font: .interSemibold(of: 20),
//                color: .black
//            )
//            
//            searchImageView.image = UIImage(systemName: "magnifyingglass")
//            searchImageView.tintColor = .black
//            
//            createTodoLabel.configureLabel(
//                text: .Localization.createYourFirstTodoList,
//                font: .interSemibold(of: 20),
//                color: .black
//            )
//            
//            noPinnedLabel.configureLabel(
//                text: .Localization.ooopsNoPinnedListYet,
//                font: .interSemibold(of: 20),
//                color: .black
//            )
//            
//            newListButton.backgroundColor = .black
//            newListButton.layer.cornerRadius = 32.5
//            
//            let plusImage = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
//            newListButton.setImage(plusImage, for: .normal)
//            newListButton.tintColor = .white
//        }
//        
//        private func layoutSubviews() {
//            NSLayoutConstraint.activate([
//                appMiniIconImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//                appMiniIconImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
//                appMiniIconImageView.widthAnchor.constraint(equalToConstant: 31),
//                appMiniIconImageView.heightAnchor.constraint(equalToConstant: 26),
//                
//                nameAppLabel.topAnchor.constraint(equalTo: appMiniIconImageView.topAnchor),
//                nameAppLabel.leadingAnchor.constraint(equalTo: appMiniIconImageView.trailingAnchor, constant: 10),
//                
//                searchImageView.topAnchor.constraint(equalTo: appMiniIconImageView.topAnchor),
//                searchImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
//                searchImageView.widthAnchor.constraint(equalToConstant: 24),
//                searchImageView.heightAnchor.constraint(equalToConstant: 24),
//                
//                segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 65),
//                segmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
//                segmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
//                segmentedControl.heightAnchor.constraint(equalToConstant: 47),
//                
//                appImage.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
//                appImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                
//                appImageOne.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
//                appImageOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                
//                createTodoLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -160),
//                createTodoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                
//                noPinnedLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -160),
//                noPinnedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                
//                newListButton.topAnchor.constraint(equalTo: createTodoLabel.bottomAnchor, constant: 25),
//                newListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                newListButton.widthAnchor.constraint(equalToConstant: 65),
//                newListButton.heightAnchor.constraint(equalToConstant: 65),
//                
//                fullScreenView.topAnchor.constraint(equalTo: view.topAnchor),
//                fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                fullScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                fullScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//                
//                searchTextField.topAnchor.constraint(equalTo: fullScreenView.topAnchor, constant: 130),
//                searchTextField.leadingAnchor.constraint(equalTo: fullScreenView.leadingAnchor, constant: 20),
//                searchTextField.widthAnchor.constraint(equalToConstant: 255),
//                searchTextField.heightAnchor.constraint(equalToConstant: 43),
//                
//                cancelButton.topAnchor.constraint(equalTo: searchTextField.topAnchor),
//                cancelButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 20),
//                cancelButton.widthAnchor.constraint(equalToConstant: 80),
//                cancelButton.heightAnchor.constraint(equalToConstant: 40),
//            ])
//        }
//        
//        private func setupActions() {
//            newListButton.addAction(UIAction(handler: { [weak self] _ in
//                guard let self = self else { return }
//                self.presenter.goToNewListScreen()
//            }), for: .touchUpInside)
//            
//            searchImageView.isUserInteractionEnabled = true
//            searchImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchImageViewTapped)))
//        }
//        
//        @objc private func searchImageViewTapped() {
//            fullScreenView.isHidden = false
//            fullScreenView.alpha = 1
//            view.subviews.compactMap { $0 as? TodoListView }.forEach { $0.isHidden = true }
//            searchTextField.becomeFirstResponder()
//        }
//        
//        @objc private func cancelButtonTapped() {
//            fullScreenView.isHidden = true
//            fullScreenView.alpha = 0
//            searchTextField.text = ""
//            view.subviews.compactMap { $0 as? TodoListView }.forEach { $0.isHidden = false }
//            updateUI()
//        }
//        
//        private func updateUI() {
//            // Сначала скрываем все TodoListView
//            view.subviews.compactMap { $0 as? TodoListView }.forEach { $0.removeFromSuperview() }
//            
//            let listsToDisplay: [TodoList]
//            if fullScreenView.isHidden {
//                listsToDisplay = filterTodoLists()
//            } else {
//                listsToDisplay = searchTodoLists(searchTextField.text)
//            }
//            
//            if listsToDisplay.isEmpty {
//                if segmentedControl.selectedSegmentIndex == 0 {
//                    appImage.isHidden = false
//                    appImageOne.isHidden = true
//                    createTodoLabel.isHidden = false
//                    noPinnedLabel.isHidden = true
//                } else if segmentedControl.selectedSegmentIndex == 1 {
//                    appImage.isHidden = true
//                    appImageOne.isHidden = false
//                    createTodoLabel.isHidden = true
//                    noPinnedLabel.isHidden = false
//                }
//            } else {
//                appImage.isHidden = true
//                appImageOne.isHidden = true
//                createTodoLabel.isHidden = true
//                noPinnedLabel.isHidden = true
//                
//                var previousView: UIView? = segmentedControl
//                for todoList in listsToDisplay {
//                    let todoListView = TodoListView(todoList: todoList)
//                    todoListView.delegate = self
//                    view.addView(todoListView)
//                    
//                    NSLayoutConstraint.activate([
//                        todoListView.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? view.topAnchor, constant: 20),
//                        todoListView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
//                        todoListView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
//                    ])
//                    
//                    previousView = todoListView
//                }
//            }
//        }
//        
//        private func filterTodoLists() -> [TodoList] {
//            let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
//            switch selectedSegmentIndex {
//            case 0:
//                return todoLists.filter { !$0.isPinned } // Все списки, исключая закрепленные
//            case 1:
//                return todoLists.filter { $0.isPinned } // Только закрепленные списки
//            default:
//                return todoLists // По умолчанию все списки (аналогично case 0)
//            }
//        }
//
//        
//        private func searchTodoLists(_ query: String?) -> [TodoList] {
//            guard let query = query, !query.isEmpty else { return todoLists }
//            return todoLists.filter { $0.title.localizedCaseInsensitiveContains(query) }
//        }
//        
//        private func loadTodoListsFromUserDefaults() {
//            if let savedData = UserDefaults.standard.data(forKey: "TodoLists") {
//                let decoder = JSONDecoder()
//                if var loadedLists = try? decoder.decode([TodoList].self, from: savedData) {
//                    // Присвоение случайного цвета исключительно для новых списков
//                    for index in loadedLists.indices {
//                        if loadedLists[index].colorIdentifier == nil {
//                            loadedLists[index].assignRandomColor()
//                        }
//                    }
//                    todoLists = loadedLists
//                    updateUI() // Обновляем UI после загрузки данных
//                }
//            }
//        }
//
//
//
//
//
//        
//        public func addTodoList(_ todoList: TodoList) {
//            var newTodoList = todoList
//            newTodoList.assignRandomColor() // Присваиваем случайный цвет
//            
//            todoLists.append(newTodoList) // Добавляем в массив todoLists
//            saveTodoListsToUserDefaults() // Сохраняем в UserDefaults
//            updateUI() // Обновляем UI
//        }
//
//        
//        private func saveTodoListsToUserDefaults() {
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(todoLists) {
//                UserDefaults.standard.set(encoded, forKey: "TodoLists")
//            }
//        }
//
//    }
//}
//
//extension Main.View: MainView, TodoListViewDelegate {
//    func todoListViewDidSwipeToDelete(_ todoListView: TodoListView) {
//        guard let index = todoLists.firstIndex(where: { $0.id == todoListView.todoList.id }) else { return }
//        
//        todoListView.animateDeletion { [weak self] in
//            guard let self = self else { return }
//            self.todoLists.remove(at: index)
//            self.saveTodoListsToUserDefaults()
//            self.updateUI()
//        }
//    }
//}
//
//extension Main.View: CustomSegmentedControlDelegate {
//    func segmentedControlChanged(to index: Int) {
//        updateUI()
//    }
//}
//
//extension Main.View: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        updateUI()
//        return true
//    }
//}
//


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
        private let appImage: UIImageView = .init(image: .imageApp)
        private let appImageOne: UIImageView = .init(image: .imageAppOne)
        private let createTodoLabel: UILabel = .init()
        private let noPinnedLabel: UILabel = .init()
        private let newListButton: UIButton = .init()
        
        private let fullScreenView: UIView = .init()
        private let searchTextField: UITextField = .init()
        private let cancelButton: UIButton = .init()
        
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
            view.addView(appImage)
            view.addView(appImageOne)
            view.addView(createTodoLabel)
            view.addView(noPinnedLabel)
            view.addView(newListButton)
            view.addView(fullScreenView)
            
            fullScreenView.addView(searchTextField)
            fullScreenView.addView(cancelButton)
        }
        
        private func configureSubviews() {
            navigationItem.hidesBackButton = true
            
            fullScreenView.isHidden = true
            fullScreenView.backgroundColor = .white
            
            searchTextField.placeholder = "Search"
            searchTextField.backgroundColor = .white
            searchTextField.borderStyle = .roundedRect
            
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.setTitleColor(.black, for: .normal)
            cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
            
            segmentedControl.delegate = self
            
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
            
            let plusImage = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
            newListButton.setImage(plusImage, for: .normal)
            newListButton.tintColor = .white
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                appMiniIconImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                appMiniIconImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
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
                
                appImage.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
                appImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                appImageOne.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
                appImageOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                createTodoLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -160),
                createTodoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                noPinnedLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -160),
                noPinnedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                newListButton.topAnchor.constraint(equalTo: createTodoLabel.bottomAnchor, constant: 25),
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
        
        @objc private func searchImageViewTapped() {
            fullScreenView.isHidden = false
            fullScreenView.alpha = 1
            view.subviews.compactMap { $0 as? TodoListView }.forEach { $0.isHidden = true }
            searchTextField.becomeFirstResponder()
        }
        
        @objc private func cancelButtonTapped() {
            fullScreenView.isHidden = true
            fullScreenView.alpha = 0
            searchTextField.text = ""
            view.subviews.compactMap { $0 as? TodoListView }.forEach { $0.isHidden = false }
            updateUI()
        }
        
        private func updateUI() {
            // Сначала скрываем все TodoListView
            view.subviews.compactMap { $0 as? TodoListView }.forEach { $0.removeFromSuperview() }
            
            let listsToDisplay: [TodoList]
            if fullScreenView.isHidden {
                listsToDisplay = filterTodoLists()
            } else {
                listsToDisplay = searchTodoLists(searchTextField.text)
            }
            
            if listsToDisplay.isEmpty {
                if segmentedControl.selectedSegmentIndex == 0 {
                    appImage.isHidden = false
                    appImageOne.isHidden = true
                    createTodoLabel.isHidden = false
                    noPinnedLabel.isHidden = true
                } else if segmentedControl.selectedSegmentIndex == 1 {
                    appImage.isHidden = true
                    appImageOne.isHidden = false
                    createTodoLabel.isHidden = true
                    noPinnedLabel.isHidden = false
                }
            } else {
                appImage.isHidden = true
                appImageOne.isHidden = true
                createTodoLabel.isHidden = true
                noPinnedLabel.isHidden = true
                
                var previousView: UIView? = segmentedControl
                for todoList in listsToDisplay {
                    let todoListView = TodoListView(todoList: todoList)
                    todoListView.delegate = self
                    view.addView(todoListView)
                    
                    NSLayoutConstraint.activate([
                        todoListView.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? view.topAnchor, constant: 20),
                        todoListView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                        todoListView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                    ])
                    
                    previousView = todoListView
                }
            }
        }
        
        private func filterTodoLists() -> [TodoList] {
            let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
            switch selectedSegmentIndex {
            case 0:
                return todoLists.filter { !$0.isPinned } // All Lists excluding pinned
            case 1:
                return todoLists.filter { $0.isPinned } // Pinned Lists
            default:
                return todoLists.filter { !$0.isPinned } // Default to All Lists excluding pinned
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
            newTodoList.assignRandomColor() // Присваиваем случайный цвет
            
            todoLists.append(newTodoList) // Добавляем в массив todoLists
            saveTodoListsToUserDefaults() // Сохраняем в UserDefaults
            updateUI() // Обновляем UI
        }

        
        private func saveTodoListsToUserDefaults() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(todoLists) {
                UserDefaults.standard.set(encoded, forKey: "TodoLists")
            }
        }
    }
}

extension Main.View: MainView, TodoListViewDelegate {
    func todoListViewDidSwipeToDelete(_ todoListView: TodoListView) {
        guard let index = todoLists.firstIndex(where: { $0.id == todoListView.todoList.id }) else { return }
        
        todoListView.animateDeletion { [weak self] in
            guard let self = self else { return }
            self.todoLists.remove(at: index)
            self.saveTodoListsToUserDefaults()
            self.updateUI()
        }
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
