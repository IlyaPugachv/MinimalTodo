import Foundation

extension Main {
    class Presenter {
        
        // MARK: - Properties
        
        weak var view: MainView?
        
        // MARK: - Initializers
        
        public init() {
            print(#function, self)
        }
        
        deinit {
            print(#function, self)
        }
        
        // MARK: - Methods
        
        // MARK: - Actions
        
        
    }
}
