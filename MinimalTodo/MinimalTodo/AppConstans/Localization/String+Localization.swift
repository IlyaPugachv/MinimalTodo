import Foundation

extension String {
    struct Localization {
        
        //MARK: - ONBOARDING -
       
        static var writeWhatYouNeedToDoEveryday: String { localise("writeWhatYouNeedToDoEveryday") }
    }
}


public func localise(_ key: String) -> String {
    let value = NSLocalizedString(key, comment: "")
    if value != key || NSLocale.preferredLanguages.first == "en" {
        return value
    }

    guard
        let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
        let bundle = Bundle(path: path)
        else { return value }
    return NSLocalizedString(key, bundle: bundle, comment: "")
}

