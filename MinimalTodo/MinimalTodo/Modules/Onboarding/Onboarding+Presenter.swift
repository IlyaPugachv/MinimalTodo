import Foundation

extension Onboarding {
    class Presenter {
        
        // MARK: - Properties -
        
        weak var view: OnboardingView?
        
        // MARK: - Initializers
        
        public init() {
            print(#function, self)
        }
        
        deinit {
            print(#function, self)
        }
        
        // MARK: - Methods -
        
        func goToMainScreen() {
            view?.navigate(to: Main.View.init(with: .init()))
        }
    }
}
