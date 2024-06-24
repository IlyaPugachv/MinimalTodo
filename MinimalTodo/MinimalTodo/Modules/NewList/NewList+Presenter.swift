import Foundation

extension NewList {
    class Presenter {
        
        // MARK: - Properties -
        
        weak var view: NewListView?
        
        // MARK: - Initializers
        
        public init() {
            print(#function, self)
        }
        
        deinit {
            print(#function, self)
        }
        
        // MARK: - Methods -
        
        func back() {
            view?.pop(animated: true)
        }
        
        // MARK: - Actions -
        
        
    }
}
