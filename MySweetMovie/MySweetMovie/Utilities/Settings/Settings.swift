//
//  Settings.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import IosUtilities

enum SettingKey: String {
    case isAuthenticateNeeded
    case language
    case theme
}

struct Settings {
    static var isAuthenticateNeeded = UserDefault<Bool>(key: SettingKey.isAuthenticateNeeded.rawValue,
                                                        defaultValue: false)
    static var language = UserDefault<String>(key: SettingKey.language.rawValue,
                                              defaultValue: LanguageCode.english.rawValue)
    static var theme = UserDefault<Int>(key: SettingKey.theme.rawValue,
                                        defaultValue: Theme.freshOrange.rawValue)
}

