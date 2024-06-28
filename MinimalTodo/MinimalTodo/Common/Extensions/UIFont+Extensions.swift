import UIKit

extension UIFont {

    static func interBold(of size: CGFloat) -> UIFont {
       return UIFont(name: "Inter-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    static func interMedium(of size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }
    
    static func interSemibold(of size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Semibold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }
    
    static func interRegular(of size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
    
    static func interRegularLight(of size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-RegularLight", size: size) ?? .systemFont(ofSize: size, weight: .light)
    }
}
