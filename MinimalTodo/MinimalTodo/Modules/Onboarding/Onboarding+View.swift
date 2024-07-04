import UIKit

extension Onboarding {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
       
        private let appIconImageView: UIImageView = .init(image: .applicationIcon)
        private let appNameLabel: UILabel = .init()
        private let infoAboutAppLabel: UILabel = .init()
        private let continueButton: UIButton = .init()
        
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
            view.addView(appNameLabel)
            view.addView(infoAboutAppLabel)
            view.addView(continueButton)
        }
        
        private func configureSubviews() {
            
            appIconImageView.contentMode = .scaleAspectFit
            
            appNameLabel.textColor = .white
            appNameLabel.font = .interSemibold(of: 39)
            appNameLabel.text = "MinimalTodo"
            
            infoAboutAppLabel.textColor = .white
            infoAboutAppLabel.font = .interMedium(of: 18)
            infoAboutAppLabel.numberOfLines = 2
            infoAboutAppLabel.text = .Localization.writeWhatYouNeedToDoEveryday
            infoAboutAppLabel.textAlignment = .center
            
            continueButton.setTitle(.Localization.continuee, for: .normal)
            continueButton.setTitleColor(.black, for: .normal)
            continueButton.titleLabel?.font = UIFont.interMedium(of: 16)
            continueButton.backgroundColor = .white
            continueButton.layer.cornerRadius = 25
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
            
                appIconImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 250),
                appIconImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
                appIconImageView.widthAnchor.constraint(equalToConstant: 67.96),
                appIconImageView.heightAnchor.constraint(equalToConstant: 55),
            
                appNameLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 10),
                appNameLabel.centerXAnchor.constraint(equalTo: appIconImageView.centerXAnchor),
                
                infoAboutAppLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 10),
                infoAboutAppLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
                infoAboutAppLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),

                continueButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -35),
                continueButton.centerXAnchor.constraint(equalTo: appIconImageView.centerXAnchor),
                continueButton.widthAnchor.constraint(equalToConstant: 199),
                continueButton.heightAnchor.constraint(equalToConstant: 53),
            ])
        }
        
        private func setupActions() {

            continueButton.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                presenter.goToMainScreen()
            }), for: .touchUpInside)
            
        }
    }
}


// MARK: - Extension View -

extension Onboarding.View: OnboardingView {
    
}
