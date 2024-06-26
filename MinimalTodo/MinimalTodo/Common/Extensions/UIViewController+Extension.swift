import UIKit

public protocol PresenterDelegate { }

public protocol ViewDelegate: AnyObject {
    var navigationController: UINavigationController? { get }
    func pushView()
    func navigate(to nextView: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

public extension ViewDelegate {
    var navigationController: UINavigationController? { nil }
    func navigate(to nextView: UIViewController) {
        self.navigate(to: nextView, animated: true)
    }
}

extension UIViewController {
    public func pop(animated: Bool = true) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIViewController: ViewDelegate {
    func embeddedInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        return navigationController
    }
    
    public func pushView() { }
    
    @objc public func navigate(to nextView: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(nextView, animated: animated)
        }
    }
}


