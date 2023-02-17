//
//  String+Extension.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 14/12/2022.
//

import Foundation

enum LanguageCode: String, CaseIterable {
    case english = "en"
}

extension String {
    static private let preferredLanguages = NSLocale.preferredLanguages
    
    static var languageCodeDevice: String {
        guard
            let currentLanguage = preferredLanguages.first,
            let languageCode = LanguageCode.allCases.filter({ currentLanguage.lowercased().contains($0.rawValue.lowercased()) }).first
        else { return LanguageCode.english.rawValue }
        return languageCode.rawValue
    }
    
    static var localeIdentifier: String {
        return Settings.language.value
    }
        
    static func didChangeLanguage() {
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
    }
}


extension String {
    init(localizedKey key: String) {
        self.init(resourceName: .localeIdentifier, localizedKey: key)
    }
}


extension String {
    static var helloWorld: String { String(localizedKey: "helloWorld") }
    static var locked: String { String(localizedKey: "locked") }
    static var scanFaceID: String { String(localizedKey: "scanFaceID") }
}
