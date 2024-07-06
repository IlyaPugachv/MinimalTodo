import Foundation

extension String {
    struct Localization {
        
        //MARK: - ONBOARDING -
        static var writeWhatYouNeedToDoEveryday: String { localise("writeWhatYouNeedToDoEveryday") }
        static var continuee: String { localise("continuee") }
        
        //MARK: - MAIN -
        static var allList: String { localise("allList") }
        static var pinned: String { localise("pinned") }
        static var createYourFirstTodoList: String { localise("createYourFirstTodoList") }
        static var ooopsNoPinnedListYet: String { localise("ooopsNoPinnedListYet") }
        static var newList: String { localise("newList") }
        static var searchYourList: String { localise("searchYourList") }
        static var cancel: String { localise("cancel") }
        
        //MARK: - New List -
        static var title: String { localise("title") }
        static var chooseALabel: String { localise("chooseALabel") }
        static var personal: String { localise("personal") }
        static var work: String { localise("work") }
        static var finance: String { localise("finance") }
        static var other: String { localise("other") }
        
        //MARK: - ALERT -
        static var deletingYourList: String { localise("deletingYourList") }
        static var areYouSureYouWantDeleteThisList: String { localise("areYouSureYouWantDeleteThisList") }
        static var no: String { localise("no") }
        static var yes: String { localise("yes") }
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

