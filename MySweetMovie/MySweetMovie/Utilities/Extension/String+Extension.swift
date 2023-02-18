//
//  String+Extension.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 14/12/2022.
//

import Foundation
import IosUtilities

enum LanguageCode: String, CaseIterable, Identifiable {
    case english = "en"
    case vietnam = "vi"
    
    var id: String {
        return UUID().uuidString
    }
    
    var nativeName: String {
        switch self {
        case .english:
            return "English"
        case .vietnam:
            return "Tiếng Việt"
        }
    }
    
    var title: String {
        switch self {
        case .english:
            return "\(String.english) (\(nativeName))"
        case .vietnam:
            return "\(String.vietnamese) (\(nativeName))"
        }
    }
    
    func changeLanguage() {
        Settings.language.value = self.rawValue
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
    }
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
    
    var tmdbImage: String {
        if self.isEmpty {
            return self
        }
        return "https://image.tmdb.org/t/p/w500\(self)"
    }
    
    var tmdbOriginalImage: String {
        if self.isEmpty {
            return self
        }

        return "https://image.tmdb.org/t/p/original\(self)"
    }
}


extension String {
    static var helloWorld: String { String(localizedKey: "helloWorld") }
    static var locked: String { String(localizedKey: "locked") }
    static var scanFaceID: String { String(localizedKey: "scanFaceID") }
    static var english: String { String(localizedKey: "english") }
    static var vietnamese: String { String(localizedKey: "vietnamese") }
    static var error: String { String(localizedKey: "error") }
    static var cancel: String { String(localizedKey: "cancel") }
    static var home: String { String(localizedKey: "home") }
    static var nowPlaying: String { String(localizedKey: "nowPlaying") }
    static var viewAll: String { String(localizedKey: "viewAll") }
    static var trending: String { String(localizedKey: "trending") }
    static var topRated: String { String(localizedKey: "topRated") }
    static var movie: String { String(localizedKey: "movie") }
    static var tv: String { String(localizedKey: "tv") }
    static var search: String { String(localizedKey: "search") }
    static var discover: String { String(localizedKey: "discover") }
    static var setting: String { String(localizedKey: "setting") }
    static var upcoming: String { String(localizedKey: "upcoming") }
    static var vote: String { String(localizedKey: "vote") }
    static var min: String { String(localizedKey: "min") }
    static var cast: String { String(localizedKey: "cast") }
    static var crews: String { String(localizedKey: "crews") }
    static var findOutMore: String { String(localizedKey: "findOutMore") }
    static var smimilar: String { String(localizedKey: "smimilar") }
}
