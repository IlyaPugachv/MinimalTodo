import UIKit

extension Onboarding {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
       
        private let appIconImageView: UIImageView = .init(image: .applicationIcon)
        
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
        
        // MARK: - Methods -
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
            setupActions()
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .black
            view.addView(appIconImageView)
          
        }
        
        private func configureSubviews() {
            
            appIconImageView.contentMode = .scaleAspectFit
            
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
            
                appIconImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 250),
                appIconImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
                appIconImageView.widthAnchor.constraint(equalToConstant: 67.96),
                appIconImageView.heightAnchor.constraint(equalToConstant: 55),
            
            

            
            ])
        }
        
        private func setupActions() {
            
        }
    }
}


// MARK: - Extension View -

extension Onboarding.View: OnboardingView {
    
}
